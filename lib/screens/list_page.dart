import 'package:flutter/material.dart';

import '../connection.dart';
import 'form.dart';

class ListPageVIew extends StatefulWidget {
  const ListPageVIew({Key? key}) : super(key: key);

  @override
  State<ListPageVIew> createState() => _ListPageVIewState();
}

class _ListPageVIewState extends State<ListPageVIew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xampp'),
        actions: [
          IconButton(
              onPressed: () {
                Connection().truncateTable();
                setState(() {});
              },
              icon: Icon(Icons.delete_forever))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserForm(
                          isNew: true,
                          userName: '',
                          userEmail: '',
                          userPhone: '',
                          id: null,
                        ))).then((value) {
              setState(() {});
            });
          }),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: Connection().getData(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                // return const Center(child: Text('Empty'));
                return Center(child: const CircularProgressIndicator());
              }
              if (snapshot.data[0]['name'] == null) {
                return const Center(child: Text('Empty'));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: ListTile(
                        leading: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserForm(
                                            isNew: false,
                                            userName: snapshot.data[index]
                                                ['name'],
                                            userEmail: snapshot.data[index]
                                                ['email'],
                                            userPhone: snapshot.data[index]
                                                ['phone'],
                                            id: snapshot.data[index]['id'],
                                          ))).then((value) {
                                setState(() {});
                              });
                            },
                            icon: const Icon(Icons.edit)),
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
        ],
      ),
    );
  }
}
