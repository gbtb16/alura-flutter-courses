import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bytebank_v8/screens/dashboard/components/dashboard_feature_item.dart';
import 'package:bytebank_v8/screens/dashboard/dashboard_i18n.dart';
import 'package:bytebank_v8/screens/transactions_list.dart';
import 'package:bytebank_v8/screens/contacts_list.dart';
import 'package:bytebank_v8/components/container.dart';
import 'package:bytebank_v8/screens/name.dart';
import 'package:bytebank_v8/models/name.dart';

class DashboardView extends StatelessWidget {
  final DashboardViewLazyI18N _i18n;

  const DashboardView(this._i18n, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NameCubit, String>(
          builder: (context, state) => Text('Welcome, $state!'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Text(
                  'Actions',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  height: 1,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                child: SizedBox(
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ListView(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      scrollDirection: Axis.horizontal,
                      children: [
                        FeatureItem(
                          _i18n.transfer,
                          Icons.monetization_on_outlined,
                          onClick: () {
                            _showContactsList(context);
                          },
                        ),
                        FeatureItem(
                          _i18n.transactions_feed,
                          Icons.description_outlined,
                          onClick: () {
                            _showTransactionsList(context);
                          },
                        ),
                        FeatureItem(
                          _i18n.change_name,
                          Icons.person_outline,
                          onClick: () {
                            _showChangeName(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showContactsList(BuildContext blocContext) {
    push(blocContext, const ContactsListContainer());
  }

  void _showChangeName(BuildContext blocContext) {
    Navigator.of(blocContext).push(MaterialPageRoute(
      builder: (context) => BlocProvider.value(
        value: BlocProvider.of<NameCubit>(blocContext),
        child: const NameContainer(),
      ),
    ));
  }

  void _showTransactionsList(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TransactionsList(),
    ));
  }
}
