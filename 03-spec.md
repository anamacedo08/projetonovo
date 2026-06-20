Aqui está a especificação técnica detalhada do sistema ArtesaLab, estruturada conforme o formato e os padrões arquiteturais exigidos.

* /.env
* ação: criar
* descrição: Arquivo de definição estrita de variáveis de ambiente para a aplicação.

* /lib/main.dart
* ação: criar
* descrição: Ponto de entrada do aplicativo ArtesaLab. 
* Inicialização: Garante que o `DatabaseService` esteja pronto antes de carregar a UI.
* Tela Inicial (HomeScreen): Exibe vitrine de produtos e Menu Lateral dinâmico.

* /lib/core/database/database_service.dart
* ação: criar
* descrição: Singleton para SQLite. Tabelas `users`, `products` e `orders` criadas com `IF NOT EXISTS` para máxima robustez.

* /lib/features/auth/presentation/pages/login_page.dart
* ação: criar
* descrição: Tela de login com formulário funcional.

* /lib/features/auth/presentation/pages/register_page.dart
* ação: criar
* descrição: Tela de cadastro de clientes.

* /lib/features/products/presentation/pages/admin_products_page.dart
* ação: criar
* descrição: Listagem de produtos para administradores.

* /lib/features/auth/presentation/pages/admin_attendants_page.dart
* ação: criar
* descrição: Listagem de atendentes para administradores.

* /lib/features/reports/presentation/pages/admin_reports_page.dart
* ação: criar
* descrição: Dashboard financeiro simplificado para administradores.

* /lib/features/orders/presentation/pages/create_order_page.dart
* ação: criar
* descrição: Fluxo de compra para clientes.

* /lib/app/routes/app_routes.dart
* ação: criar
* descrição: Roteamento dinâmico e seguro.
