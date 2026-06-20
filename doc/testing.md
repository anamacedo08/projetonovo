# Plano de Testes e Relatório de Estabilização - ArtesaLab

## Novos Cenários de Teste (Correções)

### 1. Interface de Usuário (Home & Menu)
- **Cenário 1 (Vitrine)**: Validar se a tela inicial exibe os 3 produtos semeados. Caso não haja produtos, validar se a mensagem "Nenhum produto encontrado na vitrine." é exibida.
- **Cenário 2 (Login Screen)**: Validar se a rota `/login` apresenta campos para Email, Senha e botão de Entrar.
- **Cenário 3 (Register Screen)**: Validar se a rota `/cadastro` apresenta campos para Email, Senha e botão de Cadastrar.

### 2. Fluxo de Autenticação
- **Cenário 4 (Sucesso Login)**: Validar se, ao preencher os campos e clicar em Entrar, o usuário é redirecionado para a Home e o Drawer reflete seu perfil.
- **Cenário 5 (Erro Login)**: Validar se, ao errar a senha, uma mensagem de erro (SnackBar) é exibida.

---

## Resumo de Execução Atual
- **Testes de Core**: `test/core_test.dart` -> **PASSOU**
- **Testes de Use Cases**: `test/usecases_test.dart` -> **PASSOU**

## Cobertura e Validações
### 1. Database & Auth
- [x] Inicialização do banco com seed de administrador.
- [x] Seed de 3 produtos iniciais para vitrine.
- [x] Login com sucesso e falha.

### 2. Interface Funcional
- [x] HomeScreen com GridView dinâmico.
- [x] LoginPage com formulário de login.
- [x] RegisterPage com formulário de cadastro.
