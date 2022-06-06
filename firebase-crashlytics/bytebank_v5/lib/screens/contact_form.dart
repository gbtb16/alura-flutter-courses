import 'package:flutter/material.dart';

import 'package:bytebank_v5/database/dao/contact_dao.dart';
import 'package:bytebank_v5/models/contact.dart';

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
            const SizedBox(height: 4),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                focusColor: Theme.of(context).colorScheme.primary,
                label: const Text(
                  'Full name',
                  style: TextStyle(fontSize: 24),
                ),
                enabledBorder: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: TextField(
                controller: _accountNumberController,
                decoration: InputDecoration(
                  focusColor: Theme.of(context).colorScheme.primary,
                  label: const Text(
                    'Account number',
                    style: TextStyle(fontSize: 24),
                  ),
                  enabledBorder: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
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
