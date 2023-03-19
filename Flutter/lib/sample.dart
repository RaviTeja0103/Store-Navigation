import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  @override
  Future<void> fetchData() async {
    final url = Uri.parse('http://localhost:5000');
    print("Hiiii");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Widget build(BuildContext context) {
    fetchData();
    return Container(
      child: Text(
        "Check Out",
      ),
    );
  }
}
