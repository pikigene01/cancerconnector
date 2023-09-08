import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarService {
  static void success(String msg) {
    Get.showSnackbar(GetSnackBar(
      duration: const Duration(seconds: 2),
      message: msg,
      backgroundColor: Colors.black54,
      snackStyle: SnackStyle.GROUNDED,
      icon: const Icon(Icons.check, color: Colors.green),
      overlayColor: Colors.green,
    ));
  }

  static void error(String msg) {
    Get.showSnackbar(GetSnackBar(
      duration: const Duration(seconds: 2),
      message: msg,
      backgroundColor: Colors.black54,
      snackStyle: SnackStyle.GROUNDED,
      icon: const Icon(Icons.error, color: Colors.red),
      overlayColor: Colors.red,
    ));
  }

  static void info(String msg) {
    Get.showSnackbar(GetSnackBar(
      duration: const Duration(seconds: 2),
      message: msg,
      backgroundColor: Colors.black54,
      snackStyle: SnackStyle.GROUNDED,
      icon: const Icon(Icons.info, color: Colors.blue),
      overlayColor: Colors.blue,
    ));
  }
}
