import 'package:flutter/material.dart';

import 'package:bytebank/screens/transfer/list.dart';

void main() => runApp(const ByteBankApp());

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alura Aulas',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF1B5E20),
          onPrimary: Colors.white,
          secondary: Color(0xFF2962FF),
          onSecondary: Colors.white,
          surface: Color(0xFF1B5E20),
          onSurface: Colors.white,
          background: Colors.white,
          onBackground: Colors.black,
          error: Colors.grey,
          onError: Colors.black,
        ),
      ),
      home: const TransferLists(),
    );
  }
}
