import 'package:flutter/material.dart';
import 'package:front/utils/encyclopedia_record.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EncyclopediaScreen extends StatefulWidget {
  @override
  _EncyclopediaScreenState createState() => _EncyclopediaScreenState();
}

class _EncyclopediaScreenState extends State<EncyclopediaScreen> {
  List<EncyclopediaRecord> _boxes = [];

  @override
  void initState() {
    super.initState();
    _fetchData("");
  }

  _fetchData(String searchText) async {
    var url = 'http://10.0.2.2:5000//get/encyclopedia';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'search_text': searchText,
      }),
    );
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      setState(() {
        for (var i = 0; i < data["photo_id"].length; i++) {
          var record = EncyclopediaRecord(
              "",
              data["photo_id"][i],
              data["species_name"][i],
              data["species_description"][i],
              data["how_often_to_water"][i],
              data["amount_of_sun"][i],
              data["amount_of_water"][i],
              data["difficulty"][i]);
          _boxes.add(record);
          print(_boxes[i].speciesName);
        }
      });
    } else {
      throw Exception('Failed to load boxes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scrollable Boxes encyclopedia'),
      ),
      body: ListView.builder(
        itemCount: _boxes.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/start_plant.jpg'),
                ),
                Text(
                  'Plant species',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black54,
                  ),
                ),
              ]
          );
        },
      ),
    );
  }
}
