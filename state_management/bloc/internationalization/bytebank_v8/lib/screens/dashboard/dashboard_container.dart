import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:bytebank_v8/components/localization/i18n_container.dart';
import 'package:bytebank_v8/screens/dashboard/dashboard_i18n.dart';
import 'package:bytebank_v8/screens/dashboard/dashboard_view.dart';
import 'package:bytebank_v8/components/container.dart';
import 'package:bytebank_v8/models/name.dart';

class DashboardContainer extends BlocContainer {
  const DashboardContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit('Gabriel'),
      child: I18NLoadingContainer(
        viewKey: 'dashboard',
        creator: (messages) => DashboardView(DashboardViewLazyI18N(messages)),
      ),
    );
  }
}
