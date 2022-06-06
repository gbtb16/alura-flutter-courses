import 'dart:convert';
import 'package:http/http.dart';

import 'package:bytebank_v5/http/web_client.dart';
import 'package:bytebank_v5/models/transaction.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(apiUrl);

    final List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(
      apiUrl,
      headers: {
        'Content-Type': 'application/json',
        'password': password,
      },
      body: transactionJson,
    );

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw HttpException(_getMessageError(response.statusCode));
  }

  String _getMessageError(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode]!;
    }

    return 'Unknown error.';
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'There was an error submitting transaction.',
    401: 'Authentication failed.',
    409: 'Transaction always exist.'
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
