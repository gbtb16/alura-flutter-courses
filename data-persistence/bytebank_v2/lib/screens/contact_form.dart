import 'package:bytebank_v2/database/dao/contact_dao.dart';
import 'package:flutter/material.dart';

import 'package:bytebank_v2/models/contact.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                label: Text(
                  'Full name',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextField(
                controller: _accountNumberController,
                decoration: const InputDecoration(
                  label: Text(
                    'Account number',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    _createContact();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.secondary,
                  ),
                  child: const Text('Create'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _createContact() {
    final String name = _nameController.text;
    final int? accountNumber = int.tryParse(_accountNumberController.text);

    final Contact newContact = Contact(0, name, accountNumber);

    _dao.save(newContact).then((id) => Navigator.pop(context));
  }
}
