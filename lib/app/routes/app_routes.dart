import 'package:flutter/material.dart';
import '../../core/services/auth_service.dart';

class AppRoutes {
  static Route<dynamic> gerarRota(RouteSettings settings, AuthService authService) {
    String? papel = authService.obterNivelAcesso();
    String? rotaDestino = settings.name;

    // Exemplos de bloqueio de acesso
    if (rotaDestino == '/admin' && papel != 'ADMIN') {
      return MaterialPageRoute(builder: (_) => const RotaAcessoNegado());
    }

    if (rotaDestino == '/atendente' && papel == 'CLIENTE') {
      return MaterialPageRoute(builder: (_) => const RotaAcessoNegado());
    }

    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text('Rota: $rotaDestino')),
        body: Center(child: Text('Bem-vindo à tela $rotaDestino')),
      ),
    );
  }
}

class RotaAcessoNegado extends StatelessWidget {
  const RotaAcessoNegado({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acesso Negado')),
      body: const Center(child: Text('Você não tem permissão para acessar esta tela.')),
    );
  }
}
