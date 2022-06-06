import 'package:bytebank_v6/models/balance.dart';
import 'package:bytebank_v6/models/transfers.dart';
import 'package:flutter/material.dart';

import 'package:bytebank_v6/components/custom_text_field.dart';
import 'package:bytebank_v6/models/transfer.dart';
import 'package:provider/provider.dart';

const _appBarTitle = 'Criando Transferência';

const _labelAccountNumber = 'Número da conta';
const _hintAccountNumber = '0000';

const _labelTransferValue = 'Valor';
const _hintTransferValue = '0.00';

const _confirmButtonText = 'Confirmar';

class TransferFormulary extends StatelessWidget {
  TransferFormulary({Key? key}) : super(key: key);

  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController transferValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: CustomTextField(
                controller: accountNumberController,
                label: _labelAccountNumber,
                hint: _hintAccountNumber,
              ),
            ),
            CustomTextField(
              icon: Icons.monetization_on,
              controller: transferValueController,
              label: _labelTransferValue,
              hint: _hintTransferValue,
            ),
            ElevatedButton(
              onPressed: () => _createTransfer(context),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.primary,
              ),
              child: const Text(_confirmButtonText),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(_appBarTitle),
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    final int? accountNumber = int.tryParse(accountNumberController.text);
    final double? transferValue = double.tryParse(transferValueController.text);
    final transferIsValid =
        _validateTransfer(context, accountNumber, transferValue);

    if (transferIsValid) {
      final newTransfer = Transfer(transferValue!, accountNumber!);

      _refreshState(context, newTransfer, transferValue);

      Navigator.pop(context);
    }
  }

  _validateTransfer(context, accountNumber, transferValue) {
    final completedFields = accountNumber != null && transferValue != null;
    final hasBalance = transferValue <=
        Provider.of<Balance>(
          context,
          listen: false,
        ).balanceValue;

    return completedFields && hasBalance;
  }

  _refreshState(context, newTransfer, transferValue) {
    Provider.of<Transfers>(context, listen: false).add(newTransfer);
    Provider.of<Balance>(context, listen: false).remove(transferValue);
  }
}
