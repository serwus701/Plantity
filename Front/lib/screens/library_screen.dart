import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/encyclopedia_record.dart';

class ScrollableBoxesPageL extends StatefulWidget {
  @override
  _ScrollableBoxesPageL createState() => _ScrollableBoxesPageL();
}

class _ScrollableBoxesPageL extends State<ScrollableBoxesPageL> {
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
        title: Text('Scrollable Boxes/Library'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/start_plant.jpg'),
                ),
                Column(children: const <Widget>[
                  Text(
                    'Plant name',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.teal,
                    ),
                  ),
                  Text(
                    'Plant species',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black54,
                    ),
                  ),
                ]),
              ]);
        },
      ),
    );
  }

}
