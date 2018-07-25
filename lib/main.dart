import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


void main () async {
  runApp(new MaterialApp(
    title: "Quake Report",
    home: new Quake(),
  ));

}

class Quake  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Quake'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      
    );
  }


}



