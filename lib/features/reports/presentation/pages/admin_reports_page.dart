import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../core/database/database_service.dart';

class AdminReportsPage extends StatelessWidget {
  const AdminReportsPage({super.key});

  Future<Map<String, int>> _getReportData() async {
    final db = await DatabaseService().database;
    
    final total = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM orders')) ?? 0;
    final criados = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM orders WHERE status = ?', ['AGUARDANDO_INICIO'])) ?? 0;
    final fabricacao = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM orders WHERE status = ?', ['EM_FABRICACAO'])) ?? 0;
    final enviados = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM orders WHERE status = ?', ['ENVIADO'])) ?? 0;

    return {
      'total': total,
      'criados': criados,
      'fabricacao': fabricacao,
      'enviados': enviados,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Relatórios Analíticos')),
      body: FutureBuilder<Map<String, int>>(
        future: _getReportData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final data = snapshot.data!;
          return GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(16),
            children: [
              _buildReportCard('Total Pedidos', data['total']!, Colors.blue),
              _buildReportCard('Criados', data['criados']!, Colors.orange),
              _buildReportCard('Em Fabricação', data['fabricacao']!, Colors.amber),
              _buildReportCard('Enviados', data['enviados']!, Colors.green),
            ],
          );
        },
      ),
    );
  }

  Widget _buildReportCard(String title, int count, Color color) {
    return Card(
      color: color.withOpacity(0.1),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('$count', style: TextStyle(fontSize: 32, color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
