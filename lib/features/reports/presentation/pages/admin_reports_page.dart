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
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final report = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: ListTile(
                    title: const Text('Faturamento Total'),
                    subtitle: Text('R\$ ${report['faturamentoTotal']}'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text('Pedidos Concluídos'),
                    subtitle: Text('${report['pedidosConcluidos']}'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
