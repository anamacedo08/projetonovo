import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  Future<void> inicializar() async {
    // Inicialização básica do Firebase Messaging se configurado
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      await messaging.requestPermission();
    } catch (e) {
      print('NotificationService: Firebase não configurado ou erro: $e');
    }
  }

  Future<void> enviarPush(int clienteId, String mensagem) async {
    print('Enviando push para o cliente $clienteId: $mensagem');
  }
}
