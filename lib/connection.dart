import 'dart:convert';

import 'package:http/http.dart';

class Connection {
  String ipData = '192.168.31.77';

  Future<void> sendData(name, email, phone) async {
    var data = {'name': name, 'email': email, 'phone': phone};
    var postResponse =
        await post(Uri.parse('http://$ipData/testApp/create.php'), body: data);
    return jsonDecode(postResponse.body);
  }

  Future<dynamic> getData() async {
    var getResponse = await get(Uri.parse('http://$ipData/testApp/read.php'));
    return jsonDecode(getResponse.body);
  }

  Future<void> deleteData(id) async {
    var deleteResponse = await post(
        Uri.parse('http://$ipData/testApp/delete.php'),
        body: {'id': id});
    return jsonDecode(deleteResponse.body);
  }

  Future<void> updateData(name, email, phone, id) async {
    var data = {'name': name, 'email': email, 'phone': phone, 'id': id};
    var postResponse =
        await post(Uri.parse('http://$ipData/testApp/update.php'), body: data);
    return jsonDecode(postResponse.body);
  }
}
