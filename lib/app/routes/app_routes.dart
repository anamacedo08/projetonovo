import 'package:flutter/material.dart';
import '../../core/services/auth_service.dart';

class AppRoutes {
  static Route<dynamic> gerarRota(RouteSettings settings, AuthService authService) {
    final papel = authService.obterNivelAcesso();
    final rotaDestino = settings.name;

    // Lógica de proteção de rotas baseada na especificação
    if (rotaDestino != null && rotaDestino.startsWith('/admin') && papel != 'ADMIN') {
      return MaterialPageRoute(builder: (_) => const RotaAcessoNegado());
    }

    if (rotaDestino != null && rotaDestino.startsWith('/atendente') && papel == 'CLIENTE') {
      return MaterialPageRoute(builder: (_) => const RotaAcessoNegado());
    }

    // Mapeamento de rotas (simplificado para o exemplo)
    switch (rotaDestino) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Home'))));
      case '/login':
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Login'))));
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
