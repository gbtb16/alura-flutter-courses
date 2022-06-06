import 'package:flutter/material.dart';

import 'package:bytebank_v8/components/localization/eager_localization.dart';
import 'package:bytebank_v8/components/localization/i18n_messages.dart';

class DashboardViewI18N extends ViewI18N {
  DashboardViewI18N(BuildContext context) : super(context);

  String get transfer => localize(
        {
          'pt-br': 'Transferir',
          'en': 'Transfer',
        },
      );

  // ignore: non_constant_identifier_names
  String get transaction_feed => localize(
        {
          'pt': 'Transações',
          'en': 'Transaction Feed',
        },
      );

  // ignore: non_constant_identifier_names
  String get change_name => localize(
        {
          'pt-br': 'Alterar Nome',
          'en': 'Change Name',
        },
      );
}

class DashboardViewLazyI18N {
  final I18NMessages _messages;

  DashboardViewLazyI18N(this._messages);

  String get transfer => _messages.get('transfer');

  // ignore: non_constant_identifier_names
  String get transactions_feed => _messages.get('transactions_feed');

  // ignore: non_constant_identifier_names
  String get change_name => _messages.get('change_name');
}
