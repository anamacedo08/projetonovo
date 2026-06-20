import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/database/database_service.dart';
import 'core/services/auth_service.dart';
import 'core/services/notification_service.dart';
import 'app/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
  } catch (_) {
    debugPrint(".env file not found, using fallbacks");
  }

  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase não inicializado: $e");
  }

  final dbService = DatabaseService();
  await dbService.database;

  final authService = AuthService();
  
  final notificationService = NotificationService();
  await notificationService.inicializar();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authService),
      ],
      child: const ArtesaLabApp(),
    ),
  );
}

class ArtesaLabApp extends StatelessWidget {
  const ArtesaLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return MaterialApp(
      title: 'ArtesaLab',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => AppRoutes.gerarRota(settings, authService),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<Map<String, dynamic>>> _loadProducts() async {
    final db = await DatabaseService().database;
    return await db.query('products', where: 'excluido = 0', limit: 3);
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final papel = authService.obterNivelAcesso();

    return Scaffold(
      appBar: AppBar(title: const Text('ArtesaLab')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.brown),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('ArtesaLab', style: TextStyle(color: Colors.white, fontSize: 24)),
                  const SizedBox(height: 8),
                  Text(
                    authService.usuarioAtual?['email'] ?? 'Visitante',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            if (papel == 'VISITANTE') ...[
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Login'),
                onTap: () => Navigator.pushNamed(context, '/login'),
              ),
              ListTile(
                leading: const Icon(Icons.person_add),
                title: const Text('Cadastro'),
                onTap: () => Navigator.pushNamed(context, '/cadastro'),
              ),
            ],
            if (papel == 'CLIENTE') ...[
              ListTile(
                leading: const Icon(Icons.shopping_bag),
                title: const Text('Meus Pedidos'),
                onTap: () => Navigator.pushNamed(context, '/meus-pedidos'),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Perfil'),
                onTap: () => Navigator.pushNamed(context, '/perfil'),
              ),
            ],
            if (papel == 'ADMIN') ...[
              ListTile(
                leading: const Icon(Icons.inventory),
                title: const Text('Gestão de Produtos'),
                onTap: () => Navigator.pushNamed(context, '/admin/produtos'),
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Gestão de Atendentes'),
                onTap: () => Navigator.pushNamed(context, '/admin/atendentes'),
              ),
              ListTile(
                leading: const Icon(Icons.analytics),
                title: const Text('Relatórios'),
                onTap: () => Navigator.pushNamed(context, '/admin/relatorios'),
              ),
            ],
            if (papel == 'ATENDENTE') ...[
              ListTile(
                leading: const Icon(Icons.list_alt),
                title: const Text('Pedidos Pendentes'),
                onTap: () => Navigator.pushNamed(context, '/atendente/pedidos'),
              ),
            ],
            if (papel != 'VISITANTE')
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Sair'),
                onTap: () {
                  authService.logout();
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          final products = snapshot.data ?? [];
          if (products.isEmpty) {
            return const Center(child: Text('Nenhum produto encontrado na vitrine.'));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];
              return Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.grey[300],
                        child: const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['nome'], style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(p['descricao'] ?? '', style: const TextStyle(fontSize: 12), maxLines: 2),
                          const SizedBox(height: 4),
                          Text('R\$ ${p['preco']}', style: const TextStyle(color: Colors.brown)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
