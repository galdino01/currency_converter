import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

final _apiKey = dotenv.env['HGBRASIL_API_KEY']!;
final _uri = "https://api.hgbrasil.com/finance?format=json&key=$_apiKey";

void main() async {
  runApp(MaterialApp(
    home: Container(),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(_uri));
  return json.decode(response.body);
}
