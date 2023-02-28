import 'package:flutter/material.dart';

import 'connection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xampp'),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: Connection().getData(),
            builder: (context, snapshot) {
              if (snapshot.data[0]['name'] == null) {
                return const Center(child: Text('Empty'));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: ListTile(
                        leading: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.edit)),
                        title: Text(snapshot.data[index]['name']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data[index]['phone']),
                            Text(snapshot.data[index]['email']),
                          ],
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              Connection()
                                  .deleteData(snapshot.data[index]['id']);
                              setState(() {});
                            },
                            icon: const Icon(Icons.delete)),
                      ));
                    });
              }
            },
          )),
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
                color: Colors.redAccent.shade100.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: name,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      hintText: 'Name', label: Text('Name')),
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
                    if (name.text == "" ||
                        email.text == "" ||
                        phone.text == "") {
                      return;
                    } else {
                      Connection().sendData(name.text, email.text, phone.text);
                      setState(() {
                        name.text = "";
                        email.text = "";
                        phone.text = "";
                      });
                    }
                  },
                  child: const Text('Add'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
