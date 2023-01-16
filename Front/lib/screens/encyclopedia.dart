import 'package:flutter/material.dart';
import 'package:front/utils/encyclopedia_record.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScrollableBoxesPage extends StatefulWidget {
  @override
  _ScrollableBoxesPageState createState() => _ScrollableBoxesPageState();
}

class _ScrollableBoxesPageState extends State<ScrollableBoxesPage> {
  List<EncyclopediaRecord> _boxes = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    var url = 'http://10.0.2.2:5000//get/encyclopedia';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'search_text': "",
      }),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        for (var i = 0; i < data.length; i++) {
          print(data["photo_id"].runtimeType);
          var record = EncyclopediaRecord(
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
        title: Text('Scrollable Boxes'),
      ),
      body: ListView.builder(
        itemCount: _boxes.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0)),
            child: Text(_boxes[index].speciesName),
          );
        },
      ),
    );
  }
}
