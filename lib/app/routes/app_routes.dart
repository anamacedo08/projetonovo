import 'package:flutter/material.dart';
import '../../core/services/auth_service.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/admin_attendants_page.dart';
import '../../features/products/presentation/pages/admin_products_page.dart';
import '../../features/reports/presentation/pages/admin_reports_page.dart';
import '../../features/orders/presentation/pages/create_order_page.dart';

class AppRoutes {
  static Route<dynamic> gerarRota(RouteSettings settings, AuthService authService) {
    final papel = authService.obterNivelAcesso();
    final rotaDestino = settings.name;

    if (rotaDestino != null && rotaDestino.startsWith('/admin') && papel != 'ADMIN') {
      return MaterialPageRoute(builder: (_) => const RotaAcessoNegado());
    }

    if (rotaDestino != null && rotaDestino.startsWith('/pedidos') && papel == 'VISITANTE') {
      return MaterialPageRoute(builder: (_) => const LoginPage());
    }

    switch (rotaDestino) {
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/cadastro':
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case '/admin/produtos':
        return MaterialPageRoute(builder: (_) => const AdminProductsPage());
      case '/admin/atendentes':
        return MaterialPageRoute(builder: (_) => const AdminAttendantsPage());
      case '/admin/relatorios':
        return MaterialPageRoute(builder: (_) => const AdminReportsPage());
      case '/pedidos/novo':
        return MaterialPageRoute(builder: (_) => const CreateOrderPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: Text('Rota: $rotaDestino')),
            body: Center(child: Text('Conteúdo de $rotaDestino')),
          ),
        );
    }
  }
}

class RotaAcessoNegado extends StatelessWidget {
  const RotaAcessoNegado({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acesso Negado')),
      body: const Center(
        child: Text('Você não tem permissão para acessar esta tela.'),
      ),
    );
  }
}
