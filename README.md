# ArtesaLab

Sistema completo para gestão de produtos artesanais.

## Soluções Implementadas
- **Fluxo do Atendente**: Nova tela para gestão de pedidos, permitindo mudar o status para "EM FABRICAÇÃO" e "ENVIADO" com inclusão de código de rastreio.
- **Histórico do Cliente**: Tela "Meus Pedidos" com acompanhamento em tempo real do status das encomendas.
- **Área Administrativa**: CRUD de produtos e atendentes totalmente operacional.
- **Resiliência de Dados**: Schema SQLite aprimorado para garantir integridade das informações de pedidos e usuários.

## Tecnologias
- Flutter
- SQLite (Sqflite)
- Provider

## Execução
1. `flutter pub get`
2. `flutter run`

## Testes
`flutter test`
- `test/core_test.dart`
- `test/usecases_test.dart`
