import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bytebank_v6/models/balance.dart';
import 'package:bytebank_v6/models/transfers.dart';
import 'package:bytebank_v6/screens/dashboard/dashboard.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Balance(0)),
      ChangeNotifierProvider(create: (context) => Transfers()),
    ],
    child: const ByteBankApp(),
  ));
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ByteBank 6',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF1B5E20),
          onPrimary: Colors.white,
          secondary: Color(0xFF2962FF),
          onSecondary: Colors.white,
          background: Colors.white,
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
          error: Colors.red,
          onError: Colors.white,
        ),
      ),
      home: const Dashboard(),
    );
  }
}
