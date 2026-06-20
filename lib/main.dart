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

  // Carregar variáveis de ambiente
  await dotenv.load(fileName: ".env");

  // Inicializar Firebase (opcional, conforme spec "Se as configurações estiverem presentes")
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase não inicializado: $e");
  }

  // Inicializar serviços core
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
      child: const AppWidget(),
    ),
  );
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return MaterialApp(
      title: 'Artesanal App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => AppRoutes.gerarRota(settings, authService),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Artesanal')),
      body: const Center(child: Text('Bem-vindo ao Artesanal')),
    );
  }
}
