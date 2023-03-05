import 'package:flutter/material.dart';

import '../connection.dart';

class UserForm extends StatelessWidget {
  UserForm(
      {Key? key,
      required this.isNew,
      required this.userName,
      required this.userEmail,
      required this.userPhone,
      required this.id})
      : super(key: key);
  bool isNew;
  String userName;
  String userEmail;
  String userPhone;
  var id;

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController phone = TextEditingController();
    if (!isNew) {
      name.text = userName;
      email.text = userEmail;
      phone.text = userPhone;
    }
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                  if(isNew){
                    Connection().sendData(name.text, email.text, phone.text);
                  }else{
                    Connection().updateData(name.text, email.text, phone.text, id);
                  }
                  Navigator.pop(context);
                }
              },
              child: Text((isNew) ? 'Add' : 'Update'),
            )
          ],
        ),
      ),
    );
  }
}
