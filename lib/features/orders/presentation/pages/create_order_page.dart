import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/database/database_service.dart';
import '../../../../core/services/auth_service.dart';
import '../../domain/usecases/create_order_usecase.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  Map<String, dynamic>? _selectedProduct;
  final _addressController = TextEditingController();
  bool _isLoading = false;

  Future<List<Map<String, dynamic>>> _getProducts() async {
    final db = await DatabaseService().database;
    return await db.query('products', where: 'excluido = 0');
  }

  Future<void> _submitOrder() async {
    if (_selectedProduct == null) return;
    
    setState(() => _isLoading = true);
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final useCase = CreateOrderUseCase();
      
      await useCase.executar(
        authService.usuarioAtual!['id'],
        {
          'itens': [_selectedProduct!['nome']],
          'valor_total': _selectedProduct!['preco'],
        },
        {'rua': _addressController.text},
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pedido criado!')));
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Pedido')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _getProducts(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                final products = snapshot.data!;
                return DropdownButtonFormField<Map<String, dynamic>>(
                  decoration: const InputDecoration(labelText: 'Selecione o Produto'),
                  items: products.map((p) => DropdownMenuItem(
                    value: p,
                    child: Text(p['nome']),
                  )).toList(),
                  onChanged: (val) => setState(() => _selectedProduct = val),
                );
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Endereço de Entrega'),
            ),
            const SizedBox(height: 24),
            _isLoading 
              ? const CircularProgressIndicator()
              : ElevatedButton(onPressed: _submitOrder, child: const Text('Confirmar Pedido')),
          ],
        ),
      ),
    );
  }
}
