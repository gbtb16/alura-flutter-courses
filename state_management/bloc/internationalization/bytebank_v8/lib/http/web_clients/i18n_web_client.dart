import 'package:http/http.dart';
import 'dart:convert';

import 'package:bytebank_v8/http/web_client.dart';

// ignore: constant_identifier_names
const String messagesUrl = 'gist.githubusercontent.com';

// ignore: constant_identifier_names
const String messagesPath =
    '/gbtb16/aed5233bb73f030bcb6a5b8e66aa8f2a/raw/de7b1cc865987724aa4ecbd2cbd3c184cc4ab121/';

class I18NWebClient {
  final String viewKey;

  I18NWebClient(this.viewKey);

  Future<Map<String, dynamic>> findAll() async {
    final Uri messagesUri =
        Uri.https(messagesUrl, '$messagesPath$viewKey.json');

    final Response response = await client.get(messagesUri);

    final Map<String, dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson;
  }
}
