import 'package:flutter/material.dart';

import 'package:bytebank/models/transfer.dart';
import 'package:bytebank/screens/transfer/formulary.dart';

const _appBarTitle = 'Transferências';

class TransferLists extends StatefulWidget {
  const TransferLists({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransferListsState();
}

class _TransferListsState extends State<TransferLists> {
  final List<Transfer> transfer = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: transfer.length,
        itemBuilder: (context, index) {
          final transfers = transfer[index];
          return TransferItem(transfers);
        },
      ),
      appBar: AppBar(
        title: const Text(_appBarTitle),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TransferFormulary(),
            ),
          ).then(
            (receivedTransfer) => _refreshTransferList(receivedTransfer),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _refreshTransferList(Transfer receivedTransfer) {
    setState(() {
      transfer.add(receivedTransfer);
    });
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
        title: Text(transfer.transferValue.toString()),
        subtitle: Text(transfer.accountNumber.toString()),
      ),
    );
  }
}
