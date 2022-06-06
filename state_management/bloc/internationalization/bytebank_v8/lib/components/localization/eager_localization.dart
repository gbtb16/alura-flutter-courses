import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:bytebank_v8/components/localization/locale.dart';

class ViewI18N {
  String? _language;

  ViewI18N(BuildContext context) {
    _language = BlocProvider.of<CurrentLocaleCubit>(context).state;
  }

  String localize(Map<String, String> values) {
    assert(values.containsKey(_language));

    return values[_language]!;
  }
}
