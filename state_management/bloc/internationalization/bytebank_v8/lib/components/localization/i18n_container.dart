import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:bytebank_v8/components/localization/i18n_loading_view.dart';
import 'package:bytebank_v8/components/localization/i18n_cubit.dart';
import 'package:bytebank_v8/http/web_clients/i18n_web_client.dart';
import 'package:bytebank_v8/components/container.dart';

class I18NLoadingContainer extends BlocContainer {
  final String viewKey;
  final I18NWidgetCreator creator;

  const I18NLoadingContainer({
    Key? key,
    required this.viewKey,
    required this.creator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<I18NMessagesCubit>(
      create: (context) {
        final cubit = I18NMessagesCubit(viewKey);

        cubit.reload(I18NWebClient(viewKey));

        return cubit;
      },
      child: I18NLoadingView(creator),
    );
  }
}
