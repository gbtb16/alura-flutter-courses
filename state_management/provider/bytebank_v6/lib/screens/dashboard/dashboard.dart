import 'package:bytebank_v6/screens/dashboard/balance.dart';
import 'package:bytebank_v6/screens/deposit/deposit_form.dart';
import 'package:bytebank_v6/screens/transfer/formulary.dart';
import 'package:bytebank_v6/screens/transfer/last.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ByteBank'),
      ),
      body: ListView(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: BalanceCard(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DepositFormulary()),
                    );
                  },
                  child: const Text('Receber depósito'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransferFormulary()),
                    );
                  },
                  child: const Text('Nova transferência'),
                ),
              ],
            ),
          ),
          const LastTransfers(),
        ],
      ),
    );
  }
}
