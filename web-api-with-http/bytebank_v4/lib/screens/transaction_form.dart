import 'dart:async';
import 'package:bytebank_v4/components/progress.dart';
import 'package:flutter/material.dart';

import 'package:bytebank_v4/components/transaction_auth_dialog.dart';
import 'package:bytebank_v4/http/web_clients/transaction_web_client.dart';
import 'package:bytebank_v4/models/transaction.dart';
import 'package:bytebank_v4/models/contact.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  const TransactionForm(this.contact, {Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String transactionId = const Uuid().v4();

  bool _sending = false;
  bool isButtonActive = false;
  bool _isOnError = false;

  @override
  void initState() {
    super.initState();

    _valueController.addListener(() {
      final isButtonActive =
          _valueController.text.isNotEmpty && _valueController.text.length < 10;

      if (_valueController.text.length >= 10) {
        _isOnError = true;
      } else {
        _isOnError = false;
      }

      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  Widget build(BuildContext context) {
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
              Visibility(
                visible: _sending,
                child: const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Progress(message: 'Sending...'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
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
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: TextField(
                  controller: _valueController,
                  style: const TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    focusColor: Theme.of(context).colorScheme.primary,
                    label: const Text(
                      'Transfer value',
                    ),
                    enabledBorder: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _isOnError
                            ? Colors.red
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: isButtonActive
                        ? () {
                            final double? value =
                                double.tryParse(_valueController.text);
                            final transactionCreated = Transaction(
                                transactionId, value, widget.contact);

                            showDialog(
                              context: context,
                              builder: (contextDialog) => TransactionAuthDialog(
                                  onConfirm: (String password) {
                                _save(transactionCreated, password, context);
                              }),
                            );
                          }
                        : null,
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

  void _save(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    // ignore: unused_local_variable
    Transaction transaction =
        await _send(transactionCreated, password, context);

    // ignore: use_build_context_synchronously
    _showSucessfulMessage(context);
  }

  Future<Transaction> _send(Transaction transactionCreated, String password,
      BuildContext context) async {
    setState(() {
      _sending = true;
    });

    final Transaction transaction =
        await _webClient.save(transactionCreated, password).catchError(
      (error) {
        _showFailureMessage(context, message: error.message);
      },
      test: (error) => error is HttpException,
    ).catchError(
      (error) {
        _showFailureMessage(context,
            message: 'Timeout subtmitting the transaction.');
      },
      test: (error) => error is TimeoutException,
    ).catchError(
      (error) {
        _showFailureMessage(context);
      },
      test: (error) => error is Exception,
    ).whenComplete(() {
      setState(() {
        _sending = false;
      });
    });

    return transaction;
  }

  Future<void> _showSucessfulMessage(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(
              Icons.done,
              color: Colors.green,
            ),
            SizedBox(width: 8),
            Text('Sucessful transaction!'),
          ],
        ),
      ),
    );
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  void _showFailureMessage(BuildContext context,
      {String message = 'Unknown error.'}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.warning,
              color: Colors.red,
            ),
            const SizedBox(width: 8),
            Text(message),
          ],
        ),
      ),
    );
  }
}
