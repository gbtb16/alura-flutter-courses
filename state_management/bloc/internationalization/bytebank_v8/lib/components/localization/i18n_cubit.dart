import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter/material.dart';

import 'package:bytebank_v8/components/localization/i18n_messages.dart';
import 'package:bytebank_v8/components/localization/i18n_state.dart';
import 'package:bytebank_v8/http/web_clients/i18n_web_client.dart';

class I18NMessagesCubit extends Cubit<I18NMessagesState> {
  final LocalStorage storage = LocalStorage('local_unsecure_version_1.json');
  final String _viewKey;

  I18NMessagesCubit(this._viewKey) : super(const InitI18NMessagesState());

  reload(I18NWebClient client) async {
    emit(const LoadingI18NMessagesState());

    await storage.ready;

    final items = storage.getItem(_viewKey);
    debugPrint('loaded $_viewKey $items');

    if (items != null) {
      emit(LoadedI18NMessagesState(I18NMessages(items)));
      return;
    }

    client.findAll().then(saveAndRefresh);
  }

  saveAndRefresh(Map<String, dynamic> messages) {
    debugPrint('saving $_viewKey - $messages');

    storage.setItem(_viewKey, messages);

    final loadedState = LoadedI18NMessagesState(I18NMessages(messages));
    emit(loadedState);
  }
}
