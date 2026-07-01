# ArtesaLab

Sistema completo para gestão de produtos artesanais.

## Melhorias de Interface e Relatórios
- **Visão do Atendente**: Implementado diálogo de detalhes do pedido, exibindo descrição, endereço e contato do cliente.
- **Relatórios Analíticos**: Novo dashboard para o administrador com contagem por status: Total, Em Análise, Em Fabricação e Enviados.
- **Resiliência e Performance**: Caching de vitrine e inicialização robusta mantidos e validados.

## Tecnologias
- Flutter
- SQLite (Sqflite)
- Provider
- Caching em Memória

## Execução
1. `flutter pub get`
2. `flutter run`

## Testes
Para garantir a integridade dos dados e regras de negócio:
`flutter test`
- `test/core_test.dart`
- `test/usecases_test.dart`
