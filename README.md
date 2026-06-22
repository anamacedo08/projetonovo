# ArtesaLab

Sistema completo para gestão de produtos artesanais.

## Soluções de Robustez
- **Inicialização Resiliente**: O aplicativo agora inicializa corretamente mesmo se o Firebase não estiver configurado, evitando a tela preta no startup.
- **Verificação de Firebase**: O `NotificationService` valida a existência do app Firebase antes de acessar o FCM.
- **Schema Consistente**: Tabelas `users` e `orders` garantem a existência das colunas `ativo` e `descricao_pedido` respectivamente.

## Tecnologias
- Flutter
- SQLite (Sqflite)
- Provider
- Firebase (Opcional no startup)

## Execução
1. `flutter pub get`
2. `flutter run`

## Testes
`flutter test`
