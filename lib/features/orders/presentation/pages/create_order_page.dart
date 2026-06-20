import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/services/auth_service.dart';
import '../../domain/usecases/create_order_usecase.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submitOrder() async {
    if (_descriptionController.text.isEmpty) {
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Por favor, descreva seu pedido artesanal.')));
       return;
    }
    
    setState(() => _isLoading = true);
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final useCase = CreateOrderUseCase();
      
      await useCase.executar(
        authService.usuarioAtual!['id'],
        {
          'descricao_pedido': _descriptionController.text,
        },
        {
          'endereco_entrega': _addressController.text,
          'numero_contato': _contactController.text,
        },
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sua encomenda foi enviada para avaliação!')));
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: ${e.toString()}')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Encomenda Sob Medida')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Descreva seu produto artesanal sob medida:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Ex: Vaso de cerâmica azul com detalhes dourados...',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Endereço de Entrega', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contactController,
              decoration: const InputDecoration(labelText: 'Número de Contato', border: OutlineInputBorder()),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),
            _isLoading 
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitOrder, 
                    child: const Text('Enviar para Avaliação'),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
