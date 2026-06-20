# Plano de Testes e Relatório de Estabilização - ArtesaLab

## Novos Cenários de Teste (Funcionalidades Expandidas)

### 1. Robustez do Banco de Dados
- **Cenário 1 (Init)**: Validar que a `HomeScreen` não falha se o banco ainda estiver em processo de abertura (uso de `FutureBuilder` ou `await` no main).

### 2. Telas Administrativas
- **Cenário 2 (Listagem de Produtos)**: Validar se a tela `/admin/produtos` exibe corretamente os itens inseridos via Seed.
- **Cenário 3 (Listagem de Atendentes)**: Validar se a tela `/admin/atendentes` filtra corretamente apenas usuários com `role = 'ATENDENTE'`.
- **Cenário 4 (Relatórios)**: Verificar se a tela `/admin/relatorios` exibe valores numéricos consistentes com a tabela `orders`.

### 3. Fluxo de Pedidos pelo Cliente
- **Cenário 5 (Criação de Pedido)**: Validar se o cliente consegue acessar a tela de "Novo Pedido", selecionar um produto e se o registro é criado na tabela `orders`.

---

## Resumo de Execução Atual
- **Testes de Core**: `test/core_test.dart` -> **PASSOU**
- **Testes de Use Cases**: `test/usecases_test.dart` -> **PASSOU**

## Cobertura e Validações
### 1. Database & Auth
- [x] Prevenção de erro "no such table" via inicialização assíncrona garantida no main.
- [x] Seed de Admin e Produtos.

### 2. Interface Funcional
- [x] Admin: Listagem de Produtos funcional.
- [x] Admin: Listagem de Atendentes funcional.
- [x] Admin: Relatório de Vendas funcional.
- [x] Cliente: Fluxo de criação de pedido funcional.
