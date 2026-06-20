Aqui está a especificação técnica detalhada do sistema ArtesaLab, estruturada conforme o formato e os padrões arquiteturais exigidos.

* /.env
* ação: criar
* descrição: Arquivo de definição estrita de variáveis de ambiente para a aplicação.

* /lib/main.dart
* ação: criar
* descrição: Ponto de entrada do aplicativo ArtesaLab. 
* Tela Inicial (HomeScreen): Deve carregar dinamicamente os produtos do banco de dados e exibi-los em um GridView. Caso a lista esteja vazia, deve mostrar uma mensagem informativa.
* Fluxo de Login/Cadastro: As rotas de Login e Cadastro devem conter formulários funcionais (Campos de texto para Email e Senha, e botões de ação). O Login deve autenticar via AuthService e o Cadastro deve persistir via RegisterClientUseCase.

* /lib/core/database/database_service.dart
* ação: criar
* descrição: Serviço Singleton responsável por inicializar o SQLite, tabelas e seed (Admin e 3 produtos).

* /lib/core/services/auth_service.dart
* ação: criar
* descrição: Serviço global para controle de sessão.

* /lib/app/routes/app_routes.dart
* ação: criar
* descrição: Gerenciador de rotas. Deve mapear '/login' para LoginScreen e '/cadastro' para CadastroScreen.

* /lib/features/auth/presentation/pages/login_page.dart (NOVO)
* ação: criar
* descrição: Interface de login com campos de Email, Senha e botão Entrar.

* /lib/features/auth/presentation/pages/register_page.dart (NOVO)
* ação: criar
* descrição: Interface de cadastro com campos de Email, Senha e botão Cadastrar.
