import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:http/http.dart';


class UserRepository {
  String userUrl = 'http://api.weatherapi.com/v1/current.json';

  Future getUsers() async {
    Response response = await post(Uri.parse(userUrl),
        body: {'key': '6ee5fa23515540d9b9270055231804', 'q': 'london'});

    if (response.statusCode == 200) {
      dynamic n = json.decode(response.body);
      return n;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}