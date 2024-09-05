import 'package:flutter/material.dart';
import 'package:tic_tac_toe/pages/HomeScreen.dart';

void main() {
  runApp(MaterialApp(
    builder: (context, child) {
      return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!);
    },
    title: "Tic_Tac_Toe",
    home: const HomeScreen(),
  ));
}
