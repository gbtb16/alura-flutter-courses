import 'package:bytebank_v6/screens/transfer/last.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:bytebank_v6/models/transfer.dart';
import 'package:bytebank_v6/screens/transfer/formulary.dart';
import 'package:bytebank_v6/models/transfers.dart';

const _appBarTitle = 'Transferências';

class TransfersList extends StatelessWidget {
  const TransfersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Transfers>(builder: (context, transfers, child) {
        int listSize = transfers.transfers.length;

        if (listSize == 0) {
          return const NoHasTransfer();
        }

        return ListView.builder(
          itemCount: transfers.transfers.length,
          itemBuilder: (context, index) {
            final transfer = transfers.transfers[index];
            return TransferItem(transfer);
          },
        );
      }),
      appBar: AppBar(
        title: const Text(_appBarTitle),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransferFormulary(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TransferItem extends StatelessWidget {
  final Transfer transfer;

  const TransferItem(
    this.transfer, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.monetization_on),
          ],
        ),
        title: Text(transfer.transferValueToString()),
        subtitle: Text(transfer.accountNumberToString()),
      ),
    );
  }
}
