import 'package:flutter/material.dart';
import '../../../core/services/auth_service.dart';

class AppDrawer extends StatelessWidget {
  final AuthService authService;
  final String papel;

  const AppDrawer({super.key, required this.authService, required this.papel});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.brown),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('ArtesaLab', style: TextStyle(color: Colors.white, fontSize: 24)),
                const SizedBox(height: 8),
                Text(
                  authService.usuarioAtual?['email'] ?? 'Visitante',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          if (papel == 'VISITANTE') ...[
            _buildListTile(context, Icons.login, 'Login', '/login'),
            _buildListTile(context, Icons.person_add, 'Cadastro', '/cadastro'),
          ],
          if (papel == 'CLIENTE') ...[
            _buildListTile(context, Icons.add_shopping_cart, 'Novo Pedido', '/pedidos/novo'),
            _buildListTile(context, Icons.shopping_bag, 'Minhas Encomendas', '/meus-pedidos'),
          ],
          if (papel == 'ADMIN') ...[
            _buildListTile(context, Icons.inventory, 'Gestão de Produtos', '/admin/produtos'),
            _buildListTile(context, Icons.people, 'Gestão de Atendentes', '/admin/atendentes'),
            _buildListTile(context, Icons.analytics, 'Relatórios', '/admin/relatorios'),
          ],
          if (papel == 'ATENDENTE') ...[
            _buildListTile(context, Icons.list_alt, 'Gestão de Pedidos', '/atendente/pedidos'),
          ],
          if (papel != 'VISITANTE')
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sair'),
              onTap: () {
                authService.logout();
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }
}
