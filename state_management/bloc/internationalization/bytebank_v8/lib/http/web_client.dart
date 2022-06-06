import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'package:bytebank_v8/http/interceptors/logging_interceptor.dart';

final Client client = InterceptedClient.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: const Duration(seconds: 5),
);

final Uri apiUrl = Uri(
  scheme: 'http',
  host: '192.168.1.56',
  port: 8080,
  path: 'transactions',
);
