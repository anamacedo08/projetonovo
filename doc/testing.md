# Plano de Testes e Relatório de Estabilização - ArtesaLab

## Novos Cenários de Teste (Fluxo de Pedidos)

### 1. Gestão de Pedidos pelo Atendente
- **Cenário 1 (Iniciar Fabricação)**: Validar se o atendente consegue visualizar pedidos com status "AGUARDANDO_INICIO" e alterá-los para "EM_FABRICACAO".
- **Cenário 2 (Enviar Pedido)**: Validar se o atendente consegue alterar o status de "EM_FABRICACAO" para "ENVIADO" e se o sistema exige o código de rastreio.

### 2. Histórico de Pedidos pelo Cliente
- **Cenário 3 (Visualizar Pedidos)**: Garantir que o cliente veja apenas os seus próprios pedidos na tela "Meus Pedidos" com o status atualizado corretamente.

---

## Resumo de Execução Atual
- **Testes de Core**: `test/core_test.dart` -> **PASSOU**
- **Testes de Use Cases**: `test/usecases_test.dart` -> **PASSOU**

## Cobertura e Validações
### 1. Funcionalidades Corrigidas
- [x] Schema `users` com coluna `ativo`.
- [x] Renderização de imagens de produtos funcional.
- [x] Fluxo de cadastro de atendentes funcional.
- [x] Tela de gestão de pedidos para Atendentes funcional.
- [x] Histórico de pedidos para Clientes funcional com exibição de status.
