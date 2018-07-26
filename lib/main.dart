import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Map _data;
List _features;
void main() async {
  _data = await getJson();
  _features = _data['features'];
  print(_features[0]['properties']['place']);
  runApp(new MaterialApp(
    title: "Quake Report",
    home: new Quake(),
  ));
}

class Quake extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Quake'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: new ListView.builder(
        itemCount: _features.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext context, int position) {
          if (position.isOdd) return new Divider();
          final index = position~/2;
          return new ListTile(
            title: new Text(
              "${_features[index]['properties']['place']}",
              style: new TextStyle(
                  fontSize: 19.5,
                  fontWeight: FontWeight.w500,
                  color: Colors.orange),
            ),
            subtitle: new Text(
              "${_features[index]['properties']['place']}",
              style: new TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic),
            ),
            leading: new CircleAvatar(
              backgroundColor: Colors.green,
              radius: 40.0,
              child: new Text(
                "${_features[index]['properties']['mag']}",
                style: new TextStyle(
                    fontSize: 16.5,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal),
              ),
            ),
            onTap:() {_onTapMessage(
                context,
                "M ${_features[index]['properties']['mag']} - ${_features[position]['properties']['place']} ");
            } ,
          );
        },
      ),
    );
  }

  void _onTapMessage(BuildContext context,String message){
    var alert = new AlertDialog(
      title:new Text("Quakes"),
      content: new Text(message),
      actions: <Widget>[
        new FlatButton(onPressed: (){Navigator.pop(context);},
            child: new Text("ok"))
      ],
    );
    showDialog(context: context,child:  alert);
  }
}

Future<Map> getJson() async {
  String apiUrl =
      "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson";
  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}
