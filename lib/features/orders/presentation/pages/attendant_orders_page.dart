import 'package:flutter/material.dart';
import '../../../../core/database/database_service.dart';
import '../../domain/usecases/update_order_status_usecase.dart';

class AttendantOrdersPage extends StatefulWidget {
  const AttendantOrdersPage({super.key});

  @override
  State<AttendantOrdersPage> createState() => _AttendantOrdersPageState();
}

class _AttendantOrdersPageState extends State<AttendantOrdersPage> {
  final _updateUseCase = UpdateOrderStatusUseCase();

  Future<List<Map<String, dynamic>>> _getPendingOrders() async {
    final db = await DatabaseService().database;
    return await db.query('orders', orderBy: 'data_criacao DESC');
  }

  void _showTrackingDialog(int orderId) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enviar Pedido'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Código de Rastreio'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                await _updateUseCase.executar(orderId, 'ENVIADO', dadosLogistica: {'rastreio': controller.text});
                if (mounted) {
                  Navigator.pop(context);
                  setState(() {});
                }
              }
            },
            child: const Text('Confirmar Envio'),
          ),
        ],
      ),
    );
  }

  void _showDetailsDialog(Map<String, dynamic> o) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Detalhes do Pedido #${o['id']}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Status:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${o['status']}'),
              SizedBox(height: 8),
              Text('Descrição:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${o['descricao_pedido'] ?? 'N/A'}'),
              SizedBox(height: 8),
              Text('Endereço:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${o['endereco_entrega'] ?? 'N/A'}'),
              SizedBox(height: 8),
              Text('Contato:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${o['numero_contato'] ?? 'N/A'}'),
              if (o['dados_logistica'] != null) ...[
                SizedBox(height: 8),
                Text('Logística:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${o['dados_logistica']}'),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Fechar')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestão de Pedidos (Atendente)')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getPendingOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final orders = snapshot.data ?? [];
          if (orders.isEmpty) {
            return const Center(child: Text('Nenhum pedido no sistema.'));
          }
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final o = orders[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  onTap: () => _showDetailsDialog(o),
                  title: Text('Pedido #${o['id']} - ${o['status']}'),
                  subtitle: Text('Descrição: ${o['descricao_pedido'] ?? 'N/A'}'),
                  trailing: _buildActions(o),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget? _buildActions(Map<String, dynamic> o) {
    if (o['status'] == 'AGUARDANDO_INICIO') {
      return ElevatedButton(
        onPressed: () async {
          await _updateUseCase.executar(o['id'], 'EM_FABRICACAO');
          setState(() {});
        },
        child: const Text('Iniciar Fabricação'),
      );
    } else if (o['status'] == 'EM_FABRICACAO') {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
        onPressed: () => _showTrackingDialog(o['id']),
        child: const Text('Enviar'),
      );
    }
    return null;
  }
}
