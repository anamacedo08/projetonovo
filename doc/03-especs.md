Aqui está a especificação técnica detalhada do sistema ArtesaLab, otimizada com padrões arquiteturais modernos.

* /.env
* ação: criar
* descrição: Arquivo de variáveis de ambiente.

* /lib/main.dart
* ação: criar
* descrição: Ponto de entrada do aplicativo. 
* Inicialização: Resiliente a falhas no Firebase.
* UI: Modularizada através de widgets reutilizáveis (`AppDrawer`, `ProductCard`).
* Cache: Utiliza cache em memória para a vitrine de produtos através do `ProductRepository`.

* /lib/core/database/database_service.dart
* ação: criar
* descrição: Gerenciador de conexão SQLite (Singleton). Delega criação de tabelas para `DatabaseSchema`.

* /lib/core/database/database_schema.dart (NOVO)
* ação: criar
* descrição: Define o schema das tabelas e a lógica de seeding inicial.

* /lib/core/database/base_repository.dart (NOVO)
* ação: criar
* descrição: Classe abstrata para operações genéricas de CRUD no banco de dados.

* /lib/features/*/domain/repositories/ (NOVO)
* ação: criar
* descrição: Repositórios especializados para `users`, `products` e `orders`, centralizando o acesso a dados e implementando estratégias de cache.

* /lib/features/auth/presentation/pages/login_page.dart
* ação: criar
* descrição: Login funcional.

* /lib/features/auth/presentation/pages/register_page.dart
* ação: criar
* descrição: Cadastro de clientes.

* /lib/features/products/presentation/pages/admin_products_page.dart
* ação: criar
* descrição: CRUD de produtos para administradores.

* /lib/features/auth/presentation/pages/admin_attendants_page.dart
* ação: criar
* descrição: CRUD de atendentes para administradores.

* /lib/features/reports/presentation/pages/admin_reports_page.dart
* ação: criar
* descrição: Dashboard analítico.

* /lib/features/orders/presentation/pages/create_order_page.dart
* ação: criar
* descrição: Fluxo de encomenda sob medida.

* /lib/features/orders/presentation/pages/my_orders_page.dart
* ação: criar
* descrição: Histórico de pedidos do cliente.

* /lib/features/orders/presentation/pages/attendant_orders_page.dart
* ação: criar
* descrição: Gestão operacional de pedidos pelo atendente.

* /lib/app/routes/app_routes.dart
* ação: criar
* descrição: Roteamento dinâmico e seguro.
