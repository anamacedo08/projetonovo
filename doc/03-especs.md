Aqui está a especificação técnica detalhada do sistema ArtesaLab, estruturada conforme o formato e os padrões arquiteturais exigidos.

* /.env
* ação: criar
* descrição: Arquivo de variáveis de ambiente.

* /lib/main.dart
* ação: criar
* descrição: Ponto de entrada do aplicativo. 
* Inicialização: DEVE ser resiliente a falhas em serviços externos (Firebase, etc). Se um serviço falhar, o app deve prosseguir para o `runApp`.
* Robustez: O carregamento do banco de dados e serviços core deve ser concluído antes da exibição da UI principal para evitar telas pretas ou em branco.

* /lib/core/database/database_service.dart
* ação: criar
* descrição: Singleton para SQLite. Gerencia tabelas e persistência.

* /lib/core/services/notification_service.dart
* ação: criar
* descrição: Serviço de notificações. DEVE verificar se o Firebase foi inicializado corretamente antes de tentar acessar qualquer instância do FCM para evitar erros fatais.

* /lib/features/auth/presentation/pages/login_page.dart
* ação: criar
* descrição: Login funcional.

* /lib/features/auth/presentation/pages/register_page.dart
* action: criar
* descrição: Cadastro de clientes.

* /lib/features/products/presentation/pages/admin_products_page.dart
* ação: criar
* descrição: CRUD de produtos.

* /lib/features/auth/presentation/pages/admin_attendants_page.dart
* ação: criar
* descrição: CRUD de atendentes.

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
