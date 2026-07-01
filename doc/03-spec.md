Aqui está a especificação técnica detalhada do sistema ArtesaLab, estruturada conforme o formato e os padrões arquiteturais exigidos.

* /.env
* ação: criar
* descrição: Arquivo de variáveis de ambiente.

* /lib/main.dart
* ação: criar
* descrição: Ponto de entrada do aplicativo. 
* Inicialização: Garante que o `DatabaseService` esteja pronto.
* HomeScreen: Vitrine e Drawer dinâmico com links para gestão de pedidos.

* /lib/core/database/database_service.dart
* ação: criar
* descrição: Singleton para SQLite. Gerencia persistência de usuários, produtos e encomendas.

* /lib/features/auth/presentation/pages/login_page.dart
* ação: criar
* descrição: Tela de login funcional.

* /lib/features/auth/presentation/pages/register_page.dart
* ação: criar
* descrição: Tela de cadastro de clientes.

* /lib/features/products/presentation/pages/admin_products_page.dart
* ação: criar
* descrição: CRUD de produtos para administradores com suporte a links de imagens.

* /lib/features/auth/presentation/pages/admin_attendants_page.dart
* ação: criar
* descrição: CRUD de atendentes para administradores.

* /lib/features/reports/presentation/pages/admin_reports_page.dart
* ação: criar
* descrição: Dashboard financeiro e operacional.

* /lib/features/orders/presentation/pages/create_order_page.dart
* ação: criar
* descrição: Fluxo de encomenda sob medida.

* /lib/features/orders/presentation/pages/my_orders_page.dart
* ação: criar
* descrição: Visualização do histórico de pedidos do cliente com status atualizado.

* /lib/features/orders/presentation/pages/attendant_orders_page.dart
* ação: criar
* descrição: Gestão operacional de pedidos pelo atendente (Mudança de status e código de rastreio).

* /lib/app/routes/app_routes.dart
* ação: criar
* descrição: Roteamento dinâmico e seguro.
