import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  final String? message;

  const Progress({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 10),
          Text(message ?? 'Loading'),
        ],
      ),
    );
  }
}
