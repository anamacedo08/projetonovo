import 'package:flutter/material.dart';
import '../../domain/usecases/generate_sales_report_usecase.dart';

class AdminReportsPage extends StatelessWidget {
  const AdminReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final useCase = GenerateSalesReportUseCase();

    return Scaffold(
      appBar: AppBar(title: const Text('Relatórios de Vendas')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: useCase.executar(DateTime.now().subtract(const Duration(days: 30)), DateTime.now()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          final report = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildStatCard('Total de Pedidos', report['total'].toString(), Colors.blue),
                _buildStatCard('Em Análise', report['emAnalise'].toString(), Colors.orange),
                _buildStatCard('Em Fabricação', report['emFabricacao'].toString(), Colors.amber),
                _buildStatCard('Enviados', report['enviados'].toString(), Colors.green),
                _buildStatCard('Faturamento', 'R\$ ${report['faturamentoTotal']}', Colors.brown),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 20, color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
