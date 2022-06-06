import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';

import 'package:bytebank_v8/http/web_clients/transaction_web_client.dart';
import 'package:bytebank_v8/components/transaction_auth_dialog.dart';
import 'package:bytebank_v8/components/container.dart';
import 'package:bytebank_v8/components/progress/progress_view.dart';
import 'package:bytebank_v8/models/transaction.dart';
import 'package:bytebank_v8/components/error/error_view.dart';
import 'package:bytebank_v8/models/contact.dart';

@immutable
abstract class TransactionFormState {
  const TransactionFormState();
}

@immutable
class ShowFormState extends TransactionFormState {
  const ShowFormState();
}

@immutable
class SendingFormState extends TransactionFormState {
  const SendingFormState();
}

@immutable
class SentFormState extends TransactionFormState {
  const SentFormState();
}

@immutable
class FatalErrorFormState extends TransactionFormState {
  final Map<String, String> _message;

  const FatalErrorFormState(this._message);
}

class TransactionFormCubit extends Cubit<TransactionFormState> {
  TransactionFormCubit() : super(const ShowFormState());

  void save(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    emit(const SendingFormState());

    await _send(transactionCreated, password, context);
  }

  _send(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    await TransactionWebClient()
        .save(transactionCreated, password)
        .then(
          (transaction) => emit(
            const SentFormState(),
          ),
        )
        .catchError(
      (error) {
        emit(
          FatalErrorFormState(
            {
              'title': error.message['title'],
              'message': error.message['message'],
            },
          ),
        );
      },
      test: (error) => error is HttpException,
    ).catchError(
      (error) {
        emit(
          const FatalErrorFormState(
            {
              'title': 'Our server is unavaible',
              'message': 'Timeout submitting the transaction.'
            },
          ),
        );
      },
      test: (error) => error is TimeoutException,
    ).catchError(
      (error) {
        emit(
          const FatalErrorFormState(
            {
              'title': '\$#@%^?',
              'message': 'It was a unknown error.',
            },
          ),
        );
      },
      test: (error) => error is Exception,
    );
  }
}

class TransactionFormContainer extends BlocContainer {
  final Contact _contact;

  const TransactionFormContainer(this._contact, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionFormCubit>(
      create: (context) => TransactionFormCubit(),
      child: BlocListener<TransactionFormCubit, TransactionFormState>(
        listener: (context, state) {
          if (state is SentFormState) {
            Navigator.pop(context);
            _showSucessfulMessage(context);
          }

          if (state is FatalErrorFormState) {
            _showFailureMessage(context, message: state._message['message']!);
          }
        },
        child: TransactionFormStateless(_contact),
      ),
    );
  }

  _showSucessfulMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
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
  }

  _showFailureMessage(
    BuildContext context, {
    String message = 'Unknown error.',
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
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

class TransactionFormStateless extends StatelessWidget {
  final Contact _contact;

  const TransactionFormStateless(this._contact, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormCubit, TransactionFormState>(
        builder: (context, state) {
      if (state is ShowFormState) {
        return _BasicForm(_contact);
      }

      if (state is SendingFormState) {
        return const ProgressView();
      }

      if (state is SentFormState) {
        return const ProgressView();
      }

      if (state is FatalErrorFormState) {
        return ErrorView({
          'title': state._message['title']!,
          'message': state._message['message']!,
        });
      }

      return const ErrorView({
        'title': 'Unknown error',
        'message': 'It was a unknown error.',
      });
    });
  }
}

class _BasicForm extends StatefulWidget {
  final Contact _contact;

  const _BasicForm(this._contact);

  @override
  State<_BasicForm> createState() => _BasicFormState();
}

class _BasicFormState extends State<_BasicForm> {
  final TextEditingController _valueController = TextEditingController();

  final String transactionId = const Uuid().v4();

  bool isButtonActive = false;
  // ignore: unused_field
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
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget._contact.name,
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      widget._contact.accountNumber.toString(),
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
                              transactionId,
                              value,
                              widget._contact,
                            );

                            showDialog(
                              context: context,
                              builder: (contextDialog) => TransactionAuthDialog(
                                onConfirm: (String password) {
                                  BlocProvider.of<TransactionFormCubit>(context)
                                      .save(
                                    transactionCreated,
                                    password,
                                    context,
                                  );
                                },
                              ),
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
}
