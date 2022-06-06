import 'package:flutter/material.dart';

import 'package:bytebank/components/custom_text_field.dart';
import 'package:bytebank/models/transfer.dart';

const _appBarTitle = 'Criando Transferência';

const _labelAccountNumber = 'Número da conta';
const _hintAccountNumber = '0000';

const _labelTransferValue = 'Valor';
const _hintTransferValue = '0.00';

const _confirmButtonText = 'Confirmar';

class TransferFormulary extends StatefulWidget {
  const TransferFormulary({Key? key}) : super(key: key);

  @override
  State<TransferFormulary> createState() => _TransferFormularyState();
}

class _TransferFormularyState extends State<TransferFormulary> {
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController transferValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
              controller: accountNumberController,
              label: _labelAccountNumber,
              hint: _hintAccountNumber,
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
                primary: Theme.of(context).colorScheme.secondary,
                textStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
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

    if (accountNumber != null && transferValue != null) {
      final createdTransfer = Transfer(
        transferValue,
        accountNumber,
      );

      Navigator.pop(context, createdTransfer);
    }
  }
}
