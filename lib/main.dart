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

  // Inicializar Firebase (Se as configurações estiverem presentes)
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("Firebase não inicializado: $e");
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
    final authService = Provider.of<AuthService>(context, listen: false);

    return MaterialApp(
      title: 'Artesanal App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => AppRoutes.gerarRota(settings, authService),
      home: const Scaffold(body: Center(child: Text('Bem-vindo ao Artesanal'))),
    );
  }
}
