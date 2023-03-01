import 'package:flutter/material.dart';

import '../connection.dart';

class UserForm extends StatefulWidget {
  UserForm({
    Key? key,
  }) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController phone = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(name.text),
            const Spacer(),
            TextField(
              controller: name,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration:
                  const InputDecoration(hintText: 'Name', label: Text('Name')),
            ),
            TextField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  hintText: 'Email', label: Text('Email')),
            ),
            TextField(
              controller: phone,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                  hintText: 'Phone', label: Text('Phone')),
            ),
            MaterialButton(
              onPressed: () {
                if (name.text == "" || email.text == "" || phone.text == "") {
                  return;
                } else {
                  Connection().sendData(name.text, email.text, phone.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            )
          ],
        ),
      ),
    );
  }
}
