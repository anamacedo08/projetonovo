import 'package:flutter/material.dart';
import '../../../../core/database/database_service.dart';

class AdminAttendantsPage extends StatelessWidget {
  const AdminAttendantsPage({super.key});

  Future<List<Map<String, dynamic>>> _getAttendants() async {
    final db = await DatabaseService().database;
    return await db.query('users', where: 'role = ?', whereArgs: ['ATENDENTE']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestão de Atendentes')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getAttendants(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final attendants = snapshot.data!;
          if (attendants.isEmpty) return const Center(child: Text('Nenhum atendente cadastrado.'));
          return ListView.builder(
            itemCount: attendants.length,
            itemBuilder: (context, index) {
              final a = attendants[index];
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(a['email']),
                subtitle: Text('Status: ${a['ativo'] == 1 ? 'Ativo' : 'Inativo'}'),
              );
            },
          );
        },
      ),
    );
  }
}
