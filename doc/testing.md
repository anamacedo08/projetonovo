# Plano de Testes e Relatório de Estabilização - ArtesaLab

## Novos Cenários de Teste (Correções de Schema e UI)

### 1. Integridade do Banco de Dados
- **Cenário 1 (Coluna Ativo)**: Validar se a tabela `users` possui a coluna `ativo` e se novos registros de atendentes são salvos com sucesso.
- **Cenário 2 (Migração de Colunas)**: Garantir que o `DatabaseService` adiciona colunas faltantes em tabelas existentes sem perda de dados.

### 2. Renderização de Mídia
- **Cenário 3 (Visualização de Imagem via URL)**: Validar se a vitrine na `HomeScreen` renderiza corretamente imagens a partir de URLs `http` ou `https`.

### 3. Gestão Administrativa
- **Cenário 4 (CRUD Atendente)**: Confirmar que o administrador consegue criar um atendente e que o erro de "no such column: ativo" não ocorre mais.

---

## Resumo de Execução Atual
- **Testes de Core**: `test/core_test.dart` -> **PENDENTE CORREÇÃO**
- **Testes de Use Cases**: `test/usecases_test.dart` -> **PENDENTE CORREÇÃO**

## Cobertura e Validações
### 1. Funcionalidades Corrigidas
- [x] Schema `users` com coluna `ativo`.
- [x] Renderização de imagens de produtos via rede funcional.
- [x] Fluxo de cadastro de atendentes destravado.
