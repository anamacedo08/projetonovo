Aqui está a especificação técnica detalhada do sistema ArtesaLab, estruturada conforme o formato e os padrões arquiteturais exigidos.

* /.env
* ação: criar
* descrição: Arquivo de definição estrita de variáveis de ambiente para a aplicação.

* /lib/main.dart
* ação: criar
* descrição: Ponto de entrada do aplicativo ArtesaLab. 
* Inicialização: Garante que o `DatabaseService` esteja pronto antes de carregar a UI.
* Tela Inicial (HomeScreen): Exibe vitrine de produtos e Menu Lateral dinâmico. Renderiza imagens com segurança para links nulos ou URLs externas.

* /lib/core/database/database_service.dart
* ação: criar
* descrição: Singleton para SQLite. Tabelas `users`, `products` e `orders` criadas com `IF NOT EXISTS`. 
* Schema `users`: DEVE conter a coluna `ativo` (INTEGER DEFAULT 1).
* Schema `products`: DEVE conter a coluna `imagem` (TEXT).
* Schema `orders`: DEVE conter a coluna `descricao_pedido` (TEXT), `status` (TEXT), `dados_logistica` (TEXT).
* Evolução: O script de inicialização deve garantir que todas as colunas necessárias existam via `ALTER TABLE` se necessário.

* /lib/features/auth/presentation/pages/login_page.dart
* ação: criar
* descrição: Tela de login funcional.

* /lib/features/auth/presentation/pages/register_page.dart
* ação: criar
* descrição: Tela de cadastro de clientes.

* /lib/features/products/presentation/pages/admin_products_page.dart
* ação: criar
* descrição: CRUD completo de produtos para administradores. Permite informar link da imagem (URL) e visualiza a miniatura.

* /lib/features/auth/presentation/pages/admin_attendants_page.dart
* ação: criar
* descrição: CRUD completo de atendentes para administradores. Garante a persistência na coluna `ativo`.

* /lib/features/reports/presentation/pages/admin_reports_page.dart
* ação: criar
* descrição: Dashboard financeiro para administradores.

* /lib/features/orders/presentation/pages/create_order_page.dart
* ação: criar
* descrição: Fluxo de encomenda sob medida. Permite ao cliente descrever o produto personalizado, endereço e contato.

* /lib/features/orders/presentation/pages/my_orders_page.dart
* ação: criar
* descrição: Tela exclusiva para clientes visualizarem o histórico de seus pedidos e o status atual de cada um.

* /lib/features/orders/presentation/pages/attendant_orders_page.dart
* ação: criar
* descrição: Tela de gestão de pedidos para o atendente. Permite visualizar pedidos pendentes, mudar status para "EM FABRICAÇÃO" e "ENVIADO" (solicitando código de rastreio).

* /lib/app/routes/app_routes.dart
* ação: criar
* descrição: Roteamento dinâmico e seguro. Mapeia novas telas de pedidos.
