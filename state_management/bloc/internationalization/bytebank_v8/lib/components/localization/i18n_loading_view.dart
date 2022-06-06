import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:bytebank_v8/components/localization/i18n_messages.dart';
import 'package:bytebank_v8/components/localization/i18n_state.dart';
import 'package:bytebank_v8/components/localization/i18n_cubit.dart';
import 'package:bytebank_v8/components/progress.dart';
import 'package:bytebank_v8/components/error/error_view.dart';

typedef I18NWidgetCreator = Widget Function(I18NMessages messages);

class I18NLoadingView extends StatelessWidget {
  final I18NWidgetCreator _creator;

  const I18NLoadingView(this._creator, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<I18NMessagesCubit, I18NMessagesState>(
      builder: (context, state) {
        if (state is InitI18NMessagesState ||
            state is LoadingI18NMessagesState) {
          return const ProgressView(
            message: 'Loading...',
          );
        }

        if (state is LoadedI18NMessagesState) {
          final messages = state.messages;
          return _creator.call(messages);
        }

        return const ErrorView(
          {
            'title': 'Erro de busca',
            'message': 'Erro ao buscar nomes na tela',
          },
        );
      },
    );
  }
}
