import 'package:flutter_test/flutter_test.dart';
import 'package:projetonovo/features/auth/domain/usecases/register_client_usecase.dart';
import 'package:projetonovo/features/orders/domain/usecases/create_order_usecase.dart';
import 'package:projetonovo/features/orders/domain/usecases/update_order_status_usecase.dart';
import 'package:projetonovo/core/database/database_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path/path.dart';

void main() {
  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    try { await dotenv.load(); } catch (_) {}
  });

  setUp(() async {
    final dbPath = join(await getDatabasesPath(), 'artesanal.db');
    await DatabaseService.reset();
    await deleteDatabase(dbPath);
  });

  group('RegisterClientUseCase Tests', () {
    test('Should register a new client successfully', () async {
      final useCase = RegisterClientUseCase();
      final dados = {'email': 'novo@cliente.com', 'password': '123'};
      
      await useCase.executar(dados);
      
      final db = await DatabaseService().database;
      final users = await db.query('users', where: 'email = ?', whereArgs: ['novo@cliente.com']);
      expect(users.length, 1);
      expect(users.first['role'], 'CLIENTE');
    });
  });

  group('Order UseCases Tests', () {
    test('Should create a custom order successfully', () async {
      final createUseCase = CreateOrderUseCase();
      final dadosPedido = {
        'descricao_pedido': 'Encomenda personalizada de teste'
      };
      final dadosEntrega = {
        'endereco_entrega': 'Rua Teste, 123',
        'numero_contato': '11999999999'
      };
      
      await createUseCase.executar(1, dadosPedido, dadosEntrega);
      
      final db = await DatabaseService().database;
      final orders = await db.query('orders', where: 'cliente_id = ?', whereArgs: [1]);
      expect(orders.isNotEmpty, true);
      expect(orders.first['status'], 'AGUARDANDO_INICIO');
    });

    test('Should update order status with valid transition', () async {
      final createUseCase = CreateOrderUseCase();
      await createUseCase.executar(
        1, 
        {'descricao_pedido': 'D1'}, 
        {'endereco_entrega': 'R1', 'numero_contato': 'N1'}
      );
      
      final db = await DatabaseService().database;
      final orderId = (await db.query('orders')).first['id'] as int;
      
      final updateUseCase = UpdateOrderStatusUseCase();
      await updateUseCase.executar(orderId, 'EM_FABRICACAO');
      
      final updatedOrder = (await db.query('orders', where: 'id = ?', whereArgs: [orderId])).first;
      expect(updatedOrder['status'], 'EM_FABRICACAO');
    });
  });
}
