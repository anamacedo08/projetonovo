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
    final clienteId = authService.usuarioAtual?['id'];

    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Encomendas')),
      body: clienteId == null
          ? const Center(child: Text('Usuário não identificado.'))
          : FutureBuilder<List<Map<String, dynamic>>>(
              future: _getOrders(clienteId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final orders = snapshot.data ?? [];
                if (orders.isEmpty) {
                  return const Center(child: Text('Você ainda não fez nenhuma encomenda.'));
                }
                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final o = orders[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text('Encomenda #${o['id']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Descrição: ${o['descricao_pedido']}'),
                            Text('Status: ${o['status']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            if (o['dados_logistica'] != null) Text('Logística: ${o['dados_logistica']}'),
                          ],
                        ),
                        isThreeLine: true,
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
