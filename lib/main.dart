import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:currency_converter/pages/home.dart';

final _apiKey = dotenv.get('HGBRASIL_API_KEY', fallback: null);
final _uri = 'https://api.hgbrasil.com/finance?format=json&key=$_apiKey';

Future main() async {
  await dotenv.load(fileName: ".env");

  runApp(const MaterialApp(
    home: Home(),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(_uri));
  return json.decode(response.body);
}
