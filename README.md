# ArtesaLab

Sistema completo para gestão de produtos artesanais.

## Soluções Implementadas
- **Resiliência de Dados**: Correção do schema do banco de dados (colunas `ativo` em `users` e `descricao_pedido` em `orders`).
- **Renderização de Mídia**: Correção do erro de carregamento de imagens na vitrine inicial, com suporte a URLs externas.
- **Área Administrativa**: 
    - **CRUD de Produtos**: Gerenciamento funcional com suporte a links de imagem.
    - **CRUD de Atendentes**: Cadastro e inativação de atendentes corrigidos.
- **Área do Cliente**: Encomendas sob medida com descrição personalizada.

## Tecnologias
- Flutter
- SQLite (Sqflite)
- Provider

## Execução
1. `flutter pub get`
2. `flutter run`

## Testes
`flutter test`
- `flutter test test/core_test.dart`
- `flutter test test/usecases_test.dart`
