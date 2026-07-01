import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/database/database_service.dart';
import 'core/services/auth_service.dart';
import 'core/services/notification_service.dart';
import 'app/routes/app_routes.dart';
import 'app/presentation/widgets/app_drawer.dart';
import 'features/products/domain/repositories/product_repository.dart';
import 'features/products/presentation/widgets/product_card.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("Aviso: Arquivo .env não encontrado. Usando fallbacks.");
  }

  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase não configurado ou indisponível nesta plataforma.");
  }

  try {
    await DatabaseService().database;
  } catch (e) {
    debugPrint("Erro fatal ao inicializar banco de dados: $e");
  }

  final authService = AuthService();
  final notificationService = NotificationService();
  
  try {
    await notificationService.inicializar();
  } catch (e) {
    debugPrint("Erro não fatal ao inicializar notificações.");
  }

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      ),
      onGenerateRoute: (settings) => AppRoutes.gerarRota(settings, authService),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductRepository _productRepository = ProductRepository();
  late Future<List<Map<String, dynamic>>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _productRepository.getVitrine();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final papel = authService.obterNivelAcesso();

    return Scaffold(
      appBar: AppBar(title: const Text('ArtesaLab')),
      drawer: AppDrawer(authService: authService, papel: papel),
      body: RefreshIndicator(
        onRefresh: () async {
          _productRepository.clearCache();
          setState(() {
            _productsFuture = _productRepository.getVitrine();
          });
        },
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _productsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
               return Center(child: Text('Erro ao carregar vitrine: ${snapshot.error}'));
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
              itemBuilder: (context, index) => ProductCard(product: products[index]),
            );
          },
        ),
      ),
    );
  }
}
