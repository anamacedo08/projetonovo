Aqui está a especificação técnica detalhada do sistema ArtesaLab, estruturada conforme o formato e os padrões arquiteturais exigidos.

* /.env
* ação: criar
* descrição: Arquivo de variáveis de ambiente.

* /lib/main.dart
* ação: criar
* descrição: Ponto de entrada do aplicativo. 
* Inicialização: Garante que o setup seja resiliente a falhas no Firebase.

* /lib/core/database/database_service.dart
* ação: criar
* descrição: Singleton para SQLite. Gerencia tabelas `users`, `products` e `orders`. Garante colunas `ativo` e `descricao_pedido`.

* /lib/core/services/notification_service.dart
* ação: criar
* descrição: Serviço de notificações. Verifica existência do app Firebase antes de inicializar o FCM.

* /lib/features/auth/presentation/pages/login_page.dart
* ação: criar
* descrição: Tela de login funcional.

* /lib/features/auth/presentation/pages/register_page.dart
* action: criar
* descrição: Tela de cadastro de clientes.

* /lib/features/products/presentation/pages/admin_products_page.dart
* ação: criar
* descrição: CRUD de produtos funcional.

* /lib/features/auth/presentation/pages/admin_attendants_page.dart
* ação: criar
* descrição: CRUD de atendentes funcional com suporte à coluna `ativo`.

* /lib/features/reports/presentation/pages/admin_reports_page.dart
* ação: criar
* descrição: Relatórios operacionais.

* /lib/features/orders/presentation/pages/create_order_page.dart
* ação: criar
* descrição: Encomenda sob medida.

* /lib/features/orders/presentation/pages/my_orders_page.dart
* ação: criar
* descrição: Visualização de encomendas pelo cliente.

* /lib/features/orders/presentation/pages/attendant_orders_page.dart
* ação: criar
* descrição: Gestão de status de pedidos pelo atendente.

* /lib/app/routes/app_routes.dart
* ação: criar
* descrição: Roteamento.
