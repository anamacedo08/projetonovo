# Artesanal App

Sistema para gestão artesanal com suporte a Flutter Web e Mobile.

## Tecnologias
- Flutter
- SQLite (Sqflite)
- Firebase (Messaging)
- Provider (Gestão de Estado)
- DotEnv (Configurações)

## Configuração
1. Instale as dependências:
   ```bash
   flutter pub get
   ```
2. Configure o arquivo `.env` com suas chaves:
   ```env
   APP_ENV=development
   DB_NAME=artesanal.db
   DB_VERSION=1
   ```
3. Execute o projeto:
   ```bash
   flutter run -d chrome # Para Web
   ```

## Testes
Para executar os testes automatizados:
```bash
flutter test
```

## Arquitetura
O projeto segue os princípios da Clean Architecture, com separação clara entre Domain, Core e Presentation.
- **Core**: Serviços base como Banco de Dados e Autenticação.
- **Features**: Funcionalidades isoladas com seus próprios UseCases e Controllers.
- **App**: Configurações globais e rotas.
