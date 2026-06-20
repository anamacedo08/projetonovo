Aqui está a especificação técnica detalhada do sistema ArtesaLab, estruturada conforme o formato e os padrões arquiteturais exigidos.

* /.env
* ação: criar
* descrição: Arquivo de definição estrita de variáveis de ambiente para a aplicação.

* /lib/main.dart
* ação: criar
* descrição: Ponto de entrada do aplicativo ArtesaLab. 
* Tela Inicial (HomeScreen): Carrega dinamicamente os produtos do SQLite e exibe em GridView. Possui Drawer para navegação entre perfis.

* /lib/features/auth/presentation/pages/login_page.dart
* ação: criar
* descrição: Tela de login com campos de Email, Senha e botão Entrar. Integrada com AuthService.

* /lib/features/auth/presentation/pages/register_page.dart
* ação: criar
* descrição: Tela de cadastro de clientes com campos de Email e Senha. Integrada com RegisterClientUseCase.

* /lib/core/database/database_service.dart
* ação: criar
* descrição: Gerenciamento de SQLite com Singleton e Seeding inicial de dados.

* /lib/core/services/auth_service.dart
* ação: criar
* descrição: Controle de sessão e papéis (ADMIN, ATENDENTE, CLIENTE, VISITANTE).

* /lib/app/routes/app_routes.dart
* ação: criar
* descrição: Gerenciamento dinâmico de rotas e segurança por perfil.
