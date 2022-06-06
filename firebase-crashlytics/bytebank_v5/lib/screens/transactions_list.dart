import 'package:flutter/material.dart';

import 'package:bytebank_v5/components/centered_message.dart';
import 'package:bytebank_v5/http/web_clients/transaction_web_client.dart';
import 'package:bytebank_v5/components/progress.dart';
import 'package:bytebank_v5/models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final TransactionWebClient _webClient = TransactionWebClient();

  TransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _webClient.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Transaction> transactions =
                    snapshot.data as List<Transaction>;

                if (transactions.isNotEmpty) {
                  return ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions[index];
                      return Card(
                        child: ListTile(
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.monetization_on,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ],
                          ),
                          title: Text(
                            'R\$ ${transaction.value.toString()}',
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${transaction.contact.accountNumber.toString()} - '
                            '${transaction.contact.name}',
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }

              return const CenteredMessage(
                'No transactions found',
                icon: Icons.warning,
              );
          }
          return const CenteredMessage('Unkown error');
        },
      ),
    );
  }
}
