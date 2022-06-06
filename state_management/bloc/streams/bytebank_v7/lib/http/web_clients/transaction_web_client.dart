import 'dart:convert';
import 'package:http/http.dart';

import 'package:bytebank_v7/http/web_client.dart';
import 'package:bytebank_v7/models/transaction.dart';

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

    throw HttpException(
      {
        'title': _getMessageError(response.statusCode)['title']!,
        'message': _getMessageError(response.statusCode)['message']!,
      },
    );
  }

  Map<String, String> _getMessageError(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      final listStatusCode = _statusCodeResponses[statusCode]!;

      return {
        'title': listStatusCode['title']!,
        'message': listStatusCode['message']!,
      };
    }

    return {
      'title': 'Unknown error',
      'message': 'It was a unknown error.',
    };
  }

  static final Map<int, Map<String, String>> _statusCodeResponses = {
    400: {
      'title': 'Transaction failed',
      'message': 'There was an error submitting transaction.'
    },
    401: {
      'title': 'Authentication failed',
      'message': 'Authentication failed.'
    },
    409: {
      'title': 'You did this before!',
      'message': 'Transaction always exist.'
    },
  };
}

class HttpException implements Exception {
  final Map<String, String> message;

  HttpException(this.message);
}
