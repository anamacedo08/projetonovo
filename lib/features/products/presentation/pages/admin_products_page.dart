import 'package:flutter/material.dart';
import '../../../../core/database/database_service.dart';

class AdminProductsPage extends StatelessWidget {
  const AdminProductsPage({super.key});

  Future<List<Map<String, dynamic>>> _getProducts() async {
    final db = await DatabaseService().database;
    return await db.query('products', where: 'excluido = 0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestão de Produtos')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getProducts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];
              return ListTile(
                title: Text(p['nome']),
                subtitle: Text('R\$ ${p['preco']}'),
                trailing: const Icon(Icons.edit),
              );
            },
          );
        },
      ),
    );
  }
}
