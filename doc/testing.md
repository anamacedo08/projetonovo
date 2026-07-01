# Plano de Testes e Relatório de Estabilização - ArtesaLab

## Novos Cenários de Teste (Refinamento de Interface)

### 1. Testes de Interface e Acessibilidade
- **Cenário 1 (Responsividade)**: Validar se a vitrine de produtos e as telas de gestão se adaptam corretamente a diferentes resoluções de tela (Mobile/Web).
- **Cenário 2 (Acessibilidade)**: Verificar se todos os campos de formulário possuem rótulos (labels) legíveis e se os botões fornecem feedback visual de pressionamento.
- **Cenário 3 (Estados de Carregamento)**: Validar a exibição de `CircularProgressIndicator` durante a busca de dados no banco.

### 2. Testes de Fluxo e Detalhes
- **Cenário 4 (Detalhes do Pedido - Atendente)**: Confirmar que ao selecionar um pedido na `AttendantOrdersPage`, todos os dados (descrição, endereço, contato) são exibidos corretamente em um diálogo ou tela de detalhes.
- **Cenário 5 (Relatórios do Admin)**: Validar a acurácia dos contadores de pedidos por status (Total, Em Análise, Fabricação, Enviados).

### 3. Testes de Integração e E2E
- **Cenário 6 (Fluxo Completo de Pedido)**: Cliente cria pedido -> Atendente inicia fabricação -> Atendente envia com rastreio -> Cliente visualiza status atualizado em "Meus Pedidos".

---

## Resumo de Execução Atual
- **Testes de Core**: `test/core_test.dart` -> **PASSOU**
- **Testes de Use Cases**: `test/usecases_test.dart` -> **PASSOU**

## Cobertura e Validações
### 1. Funcionalidades de Interface
- [x] Drawer dinâmico com navegação protegida.
- [x] GridView de produtos com tratamento de erros de imagem.
- [ ] Detalhes de pedido para atendente (A implementar).
- [ ] Relatórios detalhados para admin (A implementar).
