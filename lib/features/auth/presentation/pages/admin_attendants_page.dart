import 'package:flutter/material.dart';
import '../../../../core/database/database_service.dart';
import '../../domain/usecases/manage_attendant_usecase.dart';

class AdminAttendantsPage extends StatefulWidget {
  const AdminAttendantsPage({super.key});

  @override
  State<AdminAttendantsPage> createState() => _AdminAttendantsPageState();
}

class _AdminAttendantsPageState extends State<AdminAttendantsPage> {
  final ManageAttendantUseCase _useCase = ManageAttendantUseCase();

  Future<List<Map<String, dynamic>>> _getAttendants() async {
    final db = await DatabaseService().database;
    return await db.query('users', where: 'role = ?', whereArgs: ['ATENDENTE']);
  }

  void _showAddAttendantDialog() {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Novo Atendente'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: 'Senha'), obscureText: true),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () async {
              await _useCase.criarAtendente({
                'email': emailController.text,
                'password': passwordController.text,
              });
              if (mounted) {
                Navigator.pop(context);
                setState(() {});
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestão de Atendentes')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getAttendants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          final attendants = snapshot.data ?? [];
          if (attendants.isEmpty) return const Center(child: Text('Nenhum atendente cadastrado.'));
          return ListView.builder(
            itemCount: attendants.length,
            itemBuilder: (context, index) {
              final a = attendants[index];
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(a['email']),
                subtitle: Text('Status: ${a['ativo'] == 1 ? 'Ativo' : 'Inativo'}'),
                trailing: IconButton(
                  icon: Icon(a['ativo'] == 1 ? Icons.block : Icons.check_circle, color: a['ativo'] == 1 ? Colors.orange : Colors.green),
                  onPressed: () async {
                    if (a['ativo'] == 1) {
                      await _useCase.inativarAtendente(a['id']);
                    } else {
                      // O usecase original só tinha inativar, vamos adicionar um ativador simples aqui
                      final db = await DatabaseService().database;
                      await db.update('users', {'ativo': 1}, where: 'id = ?', whereArgs: [a['id']]);
                    }
                    setState(() {});
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAttendantDialog,
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
