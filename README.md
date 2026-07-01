# ArtesaLab (Refatorado)

Sistema completo para gestão de produtos artesanais, otimizado para performance e manutenibilidade.

## Melhorias de Arquitetura
- **Repository Pattern**: Centralização do acesso a dados e desacoplamento da camada de banco de dados.
- **Caching**: Implementação de cache em memória para a vitrine de produtos, reduzindo latência de I/O.
- **Modularização de UI**: Componentes comuns como Drawer e Cards extraídos para widgets independentes.
- **Schema Modular**: Separação da definição de tabelas e seeding do gerenciador de conexão.

## Tecnologias
- Flutter
- SQLite (Sqflite)
- Provider
- Caching em Memória

## Execução
1. `flutter pub get`
2. `flutter run`

## Testes
`flutter test`
