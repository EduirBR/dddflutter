import 'package:flutter/material.dart';

class NotificationService {
  static GlobalKey<ScaffoldMessengerState> notificationKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showSnackbarError(String message) {
    final snackBar = SnackBar(
      backgroundColor: const Color.fromARGB(255, 247, 16, 0),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );

    notificationKey.currentState!.showSnackBar(snackBar);
  }

  static void showSnackbarMessage(String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.blue,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );

    notificationKey.currentState!.showSnackBar(snackBar);
  }
}
