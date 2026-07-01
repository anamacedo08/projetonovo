import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/database/database_service.dart';
import '../../../../core/services/auth_service.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  Future<List<Map<String, dynamic>>> _getOrders(int clienteId) async {
    final db = await DatabaseService().database;
    return await db.query(
      'orders',
      where: 'cliente_id = ?',
      whereArgs: [clienteId],
      orderBy: 'data_criacao DESC',
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final usuario = authService.usuarioAtual;

    if (usuario == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Meus Pedidos')),
        body: const Center(child: Text('Faça login para ver seus pedidos.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Meus Pedidos')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getOrders(usuario['id']),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          final orders = snapshot.data ?? [];
          if (orders.isEmpty) {
            return const Center(child: Text('Nenhum pedido encontrado.'));
          }
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final o = orders[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text('Pedido #${o['id']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Descrição: ${o['descricao_pedido'] ?? 'N/A'}'),
                      Text('Status: ${o['status']}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.brown)),
                      if (o['dados_logistica'] != null) Text('Rastreio: ${o['dados_logistica']}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
