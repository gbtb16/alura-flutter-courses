import 'package:bytebank_v6/models/balance.dart';
import 'package:flutter/material.dart';

import 'package:bytebank_v6/components/custom_text_field.dart';
import 'package:provider/provider.dart';

const _appBarTitle = 'Receber depósito';
const _hintValueField = '0.00';
const _labelValueField = 'Valor';
const _confirmButtonText = 'Confirmar';

class DepositFormulary extends StatelessWidget {
  final TextEditingController _valueFieldController = TextEditingController();

  DepositFormulary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_appBarTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: CustomTextField(
                controller: _valueFieldController,
                hint: _hintValueField,
                label: _labelValueField,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _createDeposit(context);
              },
              child: const Text(_confirmButtonText),
            ),
          ],
        ),
      ),
    );
  }

  _createDeposit(context) {
    final double? value = double.tryParse(_valueFieldController.text);
    final depositIsValid = _validateDeposit(value);

    if (depositIsValid) {
      _refreshState(context, value);
      Navigator.pop(context);
    }
  }

  _validateDeposit(value) {
    final completedField = value != null;

    return completedField;
  }

  _refreshState(context, value) {
    Provider.of<Balance>(context, listen: false).add(value);
  }
}
