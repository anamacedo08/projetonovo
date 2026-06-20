Aqui está a especificação técnica detalhada do sistema, estruturada conforme o formato e os padrões arquiteturais exigidos.

* /.env
* ação: criar
* descrição: Arquivo de definição estrita de variáveis de ambiente para a aplicação. Não deve ser comitado no controlador de versão.
* pseudocódigo:
```text
APP_ENV=development
DB_NAME=artesanal.db
DB_VERSION=1
GITHUB_SYNC_TOKEN=SEU_TOKEN_AQUI
PUSH_PROVIDER_CONFIG={"provider":"fcm","key":"..."}

```




* /analysis_options.yaml
* ação: modificar
* descrição: Configuração de linting para garantir a qualidade de código padronizada em toda a equipe.
* pseudocódigo:
```yaml
include: package:flutter_lints/flutter.yaml
analyzer:
  strong-mode:
    implicit-casts: false
    implicit-dynamic: false

```




* /lib/main.dart
* ação: criar
* descrição: Ponto de entrada do aplicativo. Responsável por carregar as variáveis de ambiente, inicializar as dependências core (Banco, Auth) e montar a árvore de widgets principal.
* pseudocódigo:
```dart
função main() assíncrona:
  garantirInicializacaoWidgets()
  carregarVariaveisDeAmbiente()
  inicializarDatabaseService()
  inicializarAuthService()
  inicializarNotificationService()
  executarApp(AppWidget())

```




* /lib/core/database/database_service.dart
* ação: criar
* descrição: Serviço Singleton responsável por inicializar o SQLite local, aplicar migrações e inserir o Administrador inicial (seed).
* pseudocódigo:
```dart
classe DatabaseService:
  instancia = null

  função inicializar(dbName, dbVersion):
    abrirBanco(
      caminho: dbName,
      versao: dbVersion,
      aoCriar: (banco, versao) => executarScriptCriacaoTabelas(banco) e semearAdminRoot(banco),
      aoAtualizar: (banco, versaoAntiga, versaoNova) => executarScriptsMigracao(banco)
    )

  função semearAdminRoot(banco):
    banco.inserir('users', { 'role': 'admin', 'email': 'admin@artesanal.com', 'password_hash': gerarHash('senhaPadrao') })

```




* /lib/core/services/auth_service.dart
* ação: criar
* descrição: Serviço global para controle de sessão, abstraindo o acesso e as credenciais hasheadas.
* pseudocódigo:
```dart
classe AuthService:
  usuarioAtual = nulo

  função login(credenciais):
    usuario = UserRepository.buscarPorEmail(credenciais.email)
    se usuario.senhaValida(credenciais.senha):
      usuarioAtual = usuario
      notificarOuvintes()
      retornar Sucesso
    senao:
      retornar ErroNaoAutorizado

  função obterNivelAcesso():
    retornar usuarioAtual.papel // ADMIN, ATENDENTE, CLIENTE

```




* /lib/app/routes/app_routes.dart
* ação: criar
* descrição: Gerenciador de rotas dinâmico que intercepta a navegação e bloqueia telas de acordo com o nível de acesso do AuthService.
* pseudocódigo:
```dart
função gerarRota(configuracao):
  papel = AuthService.obterNivelAcesso()
  rotaDestino = configuracao.nome

  se rotaDestino exige ADMIN e papel != ADMIN:
    retornar RotaAcessoNegado()

  se rotaDestino exige ATENDENTE e papel == CLIENTE:
    retornar RotaAcessoNegado()

  retornar ConstruirRota(rotaDestino)

```




* /lib/features/auth/domain/usecases/register_client_usecase.dart
* ação: criar
* descrição: Lógica de negócio (Domain) pura para validação e autocadastro de clientes na plataforma.
* pseudocódigo:
```dart
classe RegisterClientUseCase:
  dependencia UserRepository

  função executar(dadosCliente):
    se dadosCliente.email ja existe:
      retornar ErroConflito

    hash = encriptar(dadosCliente.senha)
    novoCliente = EntidadeCliente(dados: dadosCliente, senha: hash, papel: 'CLIENTE')

    UserRepository.salvar(novoCliente)
    retornar Sucesso

```




* /lib/features/auth/domain/usecases/manage_attendant_usecase.dart
* ação: criar
* descrição: Lógica de negócio restrita a administradores para executar CRUD lógico de atendentes.
* pseudocódigo:
```dart
classe ManageAttendantUseCase:
  dependencia UserRepository

  função criarAtendente(dados):
    verificarPermissaoAdmin()
    novoAtendente = EntidadeAtendente(dados: dados, papel: 'ATENDENTE', ativo: verdadeiro)
    UserRepository.salvar(novoAtendente)

  função inativarAtendente(id):
    verificarPermissaoAdmin()
    UserRepository.atualizacaoLogica(id, ativo: falso)

```




* /lib/features/products/domain/usecases/manage_products_usecase.dart
* ação: criar
* descrição: Orquestração de exclusão lógica, edição e criação de produtos da vitrine pelo administrador.
* pseudocódigo:
```dart
classe ManageProductsUseCase:
  dependencia ProductRepository

  função salvarProduto(produto):
    verificarPermissaoAdmin()
    se produto.id nulo:
      ProductRepository.inserir(produto)
    senao:
      ProductRepository.atualizar(produto)

  função exclusaoLogica(id):
    verificarPermissaoAdmin()
    ProductRepository.atualizarStatus(id, excluido: verdadeiro)

```




* /lib/features/orders/domain/usecases/create_order_usecase.dart
* ação: criar
* descrição: Regra de negócio para consolidação do carrinho, personalização e endereço, gerando o pedido.
* pseudocódigo:
```dart
classe CreateOrderUseCase:
  dependencia OrderRepository

  função executar(dadosPedido, dadosEntrega):
    validarParametrosPersonalizacao(dadosPedido)
    validarEndereco(dadosEntrega)

    pedido = EntidadePedido(
      cliente: AuthService.usuarioAtual,
      produtos: dadosPedido.itens,
      endereco: dadosEntrega,
      status: 'AGUARDANDO_INICIO',
      dataCriacao: Agora()
    )

    OrderRepository.salvar(pedido)

```




* /lib/features/orders/domain/usecases/update_order_status_usecase.dart
* ação: criar
* descrição: Controle rigoroso de máquina de estados do pedido feito pelo atendente, disparando push ao cliente.
* pseudocódigo:
```dart
classe UpdateOrderStatusUseCase:
  dependencia OrderRepository
  dependencia NotificationService

  função executar(idPedido, novoStatus, dadosLogistica = nulo):
    pedido = OrderRepository.buscar(idPedido)

    se pedido.status == 'AGUARDANDO_INICIO' e novoStatus == 'EM_FABRICACAO':
      pedido.status = novoStatus
    senao se pedido.status == 'EM_FABRICACAO' e novoStatus == 'ENVIADO':
      validarPresencaDados(dadosLogistica.rastreio)
      pedido.status = novoStatus
      pedido.dadosLogistica = dadosLogistica
    senao:
      retornar ErroTransicaoInvalida

    OrderRepository.atualizar(pedido)
    NotificationService.enviarPush(pedido.clienteId, "Status atualizado para: " + novoStatus)

```




* /lib/features/orders/presentation/controllers/order_controller.dart
* ação: criar
* descrição: Gerenciamento de estado (BLoC ou ChangeNotifier) que intercepta interações da interface e invoca UseCases de pedidos.
* pseudocódigo:
```dart
classe OrderController estende ChangeNotifier:
  estado = Carregando
  pedidos = []

  função carregarMeusPedidos():
    estado = Carregando
    notificarOuvintes()

    resultado = GetOrdersUseCase.executar(AuthService.usuarioAtual.id)
    se resultado.sucesso:
      pedidos = resultado.dados
      estado = Concluido
    senao:
      estado = Erro(resultado.mensagem)

    notificarOuvintes()

```




* /lib/features/reports/domain/usecases/generate_sales_report_usecase.dart
* ação: criar
* descrição: Geração de painel analítico administrativo lendo o SQLite para agregar faturamento e tempos de produção.
* pseudocódigo:
```dart
classe GenerateSalesReportUseCase:
  dependencia OrderRepository

  função executar(periodoInicial, periodoFinal):
    verificarPermissaoAdmin()
    pedidos = OrderRepository.buscarPorPeriodo(periodoInicial, periodoFinal)

    faturamentoTotal = somar(pedidos.valor)
    tempoMedio = calcularMedia(pedidos.dataEnvio - pedidos.dataIniciadaFabricacao)

    retornar EntidadeRelatorio(faturamentoTotal, tempoMedio, pedidosConcluidos)

```