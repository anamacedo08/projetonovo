# ArtesaLab

Sistema completo para gestão de produtos artesanais.

## Soluções Implementadas
- **Resiliência de Dados**: Correção do erro de inicialização de tabelas via `onOpen` e inicialização síncrona no `main`.
- **Área Administrativa**: Telas funcionais para gestão de produtos, atendentes e visualização de relatórios de vendas.
- **Área do Cliente**: Fluxo funcional para criação de novos pedidos diretamente pela aplicação.
- **Autenticação**: Telas de login e cadastro totalmente integradas ao banco de dados local.

## Tecnologias
- Flutter
- SQLite (Sqflite)
- Provider
- Firebase Core/Messaging (Simulado)

## Execução
1. `flutter pub get`
2. `flutter run`

## Testes
Para garantir a estabilidade das regras de negócio:
`flutter test` (Recomendado rodar individualmente para evitar travas de banco em FFI).
- `flutter test test/core_test.dart`
- `flutter test test/usecases_test.dart`
