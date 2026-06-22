import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  Future<void> inicializar() async {
    // Verifica se o Firebase foi inicializado antes de prosseguir
    if (Firebase.apps.isEmpty) {
      debugPrint('NotificationService: Firebase não inicializado. Ignorando setup do FCM.');
      return;
    }

    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    } catch (e) {
      debugPrint('NotificationService: Erro ao configurar FCM: $e');
    }
  }

  Future<void> enviarPush(int clienteId, String mensagem) async {
    debugPrint('Enviando push simulado para o cliente $clienteId: $mensagem');
  }
}
