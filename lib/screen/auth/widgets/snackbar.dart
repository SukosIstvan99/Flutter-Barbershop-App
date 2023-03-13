import 'package:barbershop/utils/constants/theme.dart';
import 'package:flutter/material.dart';

void showTextMessage(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: kPrimaryColor,
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}
