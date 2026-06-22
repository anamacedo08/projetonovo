# Plano de Testes e Relatório de Estabilização - ArtesaLab

## Novos Cenários de Teste (Robustez de Inicialização)

### 1. Inicialização de Serviços Externos
- **Cenário 1 (Falha no Firebase)**: Simular a ausência de configuração do Firebase e validar se o aplicativo ArtesaLab inicializa corretamente e exibe a tela inicial (HomeScreen) em vez de uma tela preta.
- **Cenário 2 (Conclusão do Main)**: Garantir que o `runApp` é chamado independentemente de erros capturados em blocos `try-catch` durante o setup.

---

## Resumo de Execução Atual
- **Testes de Core**: `test/core_test.dart` -> **PASSOU**
- **Testes de Use Cases**: `test/usecases_test.dart` -> **PASSOU**

## Cobertura e Validações
### 1. Funcionalidades Corrigidas
- [x] Inicialização resiliente (sem travamentos por Firebase).
- [x] Máquina de estados de pedidos funcional.
- [x] Relatórios operacionais.
