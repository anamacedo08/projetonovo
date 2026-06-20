# ArtesaLab

Sistema para gestão de produtos artesanais.

## Tecnologias
- Flutter
- SQLite (Sqflite)
- Firebase (Messaging)
- Provider (Gestão de Estado)

## Configuração
1. Instale as dependências: `flutter pub get`
2. Execute o app: `flutter run`

## Funcionalidades
- **Vitrine Dinâmica**: Visualização de produtos artesanais cadastrados no banco.
- **Login e Cadastro**: Telas dedicadas para autenticação e registro de novos clientes.
- **Menu por Perfil**: Opções de navegação variam de acordo com o nível de acesso (Admin, Atendente, Cliente, Visitante).
- **Gestão de Pedidos**: Fluxo completo desde a criação até a atualização de status (Backend simulado).

## Testes
Para garantir a estabilidade do sistema, execute:
```bash
flutter test
```
Os testes cobrem persistência, lógica de negócio e autenticação.
