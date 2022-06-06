import 'package:flutter/material.dart';

import 'package:bytebank_v8/components/progress/progress.dart';

class ProgressView extends StatelessWidget {
  final String message;

  const ProgressView({Key? key, this.message = 'Sending...'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Processing'),
      ),
      body: Progress(message: message),
    );
  }
}
