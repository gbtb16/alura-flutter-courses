import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:bytebank_v8/screens/dashboard/dashboard_container.dart';
import 'package:bytebank_v8/components/localization/locale.dart';
import 'package:bytebank_v8/components/theme.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(const ByteBankApp());
    },
    blocObserver: LogObserver(),
  );
}

class LogObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint('${bloc.runtimeType} -> $change');
    super.onChange(bloc, change);
  }
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ByteBank 8.0',
      theme: bytebankTheme,
      home: const LocalizationContainer(
        child: DashboardContainer(),
      ),
    );
  }
}
