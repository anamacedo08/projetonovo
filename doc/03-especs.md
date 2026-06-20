Aqui está a especificação técnica detalhada do sistema ArtesaLab, estruturada conforme o formato e os padrões arquiteturais exigidos.

* /.env
* ação: criar
* descrição: Arquivo de definição estrita de variáveis de ambiente para a aplicação.

* /lib/main.dart
* ação: criar
* descrição: Ponto de entrada do aplicativo ArtesaLab. 
* Inicialização: Deve aguardar a inicialização completa do `DatabaseService` antes de montar a árvore de widgets para evitar erros de "no such table".
* Tela Inicial (HomeScreen): Carrega dinamicamente os produtos do SQLite.

* /lib/core/database/database_service.dart
* ação: criar
* descrição: Serviço Singleton. Garante a criação das tabelas `users`, `products` e `orders` no `onCreate`. Insere Admin inicial e 3 produtos de vitrine.

* /lib/features/auth/presentation/pages/login_page.dart
* ação: criar
* descrição: Interface de login funcional.

* /lib/features/auth/presentation/pages/register_page.dart
* ação: criar
* descrição: Interface de cadastro funcional.

* /lib/features/products/presentation/pages/admin_products_page.dart (NOVO)
* ação: criar
* descrição: Lista todos os produtos cadastrados no banco para o Administrador.

* /lib/features/auth/presentation/pages/admin_attendants_page.dart (NOVO)
* ação: criar
* descrição: Lista todos os usuários com papel 'ATENDENTE' para o Administrador.

* /lib/features/reports/presentation/pages/admin_reports_page.dart (NOVO)
* ação: criar
* descrição: Exibe o faturamento total e quantidade de pedidos utilizando o `GenerateSalesReportUseCase`.

* /lib/features/orders/presentation/pages/create_order_page.dart (NOVO)
* ação: criar
* descrição: Permite ao Cliente selecionar um produto da vitrine e confirmar a criação de um pedido, persistindo no banco através do `CreateOrderUseCase`.

* /lib/app/routes/app_routes.dart
* ação: criar
* descrição: Mapeia as novas rotas funcionais: `/admin/produtos`, `/admin/atendentes`, `/admin/relatorios` e `/pedidos/novo`.
