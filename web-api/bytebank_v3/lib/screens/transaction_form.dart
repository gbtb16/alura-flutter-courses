import 'package:bytebank_v3/http/web_clients/transaction_web_client.dart';
import 'package:flutter/material.dart';

import 'package:bytebank_v3/models/transaction.dart';
import 'package:bytebank_v3/models/contact.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  const TransactionForm(this.contact, {Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();

    return Scaffold(
      appBar: AppBar(
        title: const Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.contact.name,
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    widget.contact.accountNumber.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextField(
                focusNode: focusNode,
                controller: _valueController,
                style: const TextStyle(fontSize: 24.0),
                decoration: InputDecoration(
                  focusColor: Theme.of(context).colorScheme.primary,
                  label: const Text(
                    'Value',
                  ),
                  enabledBorder: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      final double? value =
                          double.tryParse(_valueController.text);
                      final transactionCreated =
                          Transaction(value, widget.contact);
                      _webClient.save(transactionCreated).then((transaction) {
                        Navigator.pop(context);
                      });
                    },
                    child: const Text('Transfer'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
