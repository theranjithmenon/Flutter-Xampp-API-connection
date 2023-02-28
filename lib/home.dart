import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  Future<void> sendData() async {
    var data = {
      'name': name.text,
      'email': email.text,
      'phone': phone.text.toString()
    };
    var postResponse = await post(
        Uri.parse('http://192.168.1.14/testApp/create.php'),
        body: data);
    return jsonDecode(postResponse.body);
  }

  Future<dynamic> getData() async {
    var getResponse =
        await get(Uri.parse('http://192.168.1.14/testApp/read.php'));
    return jsonDecode(getResponse.body);
  }

  Future<void> deleteData(id) async {
    var deleteResponse = await post(
        Uri.parse('http://192.168.1.14/testApp/delete.php'),
        body: {'id': id});
    return jsonDecode(deleteResponse.body);
  }

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
            future: getData(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: ListTile(
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
                                deleteData(snapshot.data[index]['id']);
                                setState(() {});
                              },
                              icon: Icon(Icons.delete)),
                        ));
                  });
              }
              else{
                return Text('Empty');
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
                      sendData();
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
