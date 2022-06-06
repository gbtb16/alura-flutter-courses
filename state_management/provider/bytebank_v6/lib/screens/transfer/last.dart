import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:bytebank_v6/models/transfers.dart';
import 'package:bytebank_v6/screens/transfer/list.dart';

const _title = 'Últimas transferências';

class LastTransfers extends StatelessWidget {
  const LastTransfers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          _title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Consumer<Transfers>(builder: (context, transfers, child) {
          final lastTransfers = transfers.transfers.reversed.toList();

          final quantity = transfers.transfers.length;
          int listSize = quantity < 3 ? quantity : 2;

          if (listSize == 0) {
            return const NoHasTransfer();
          }

          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: listSize,
            itemBuilder: (context, index) {
              return TransferItem(lastTransfers[index]);
            },
          );
        }),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TransfersList()),
            );
          },
          child: const Text('Ver todas as transferências'),
        ),
      ],
    );
  }
}

class NoHasTransfer extends StatelessWidget {
  const NoHasTransfer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(40),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Você ainda não realizou nenhuma transferência!',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
