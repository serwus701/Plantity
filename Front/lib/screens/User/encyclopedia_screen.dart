import 'package:flutter/material.dart';
import 'package:front/api_requests/user_api_requests.dart';
import 'package:front/utils/encyclopedia_record.dart';

class EncyclopediaScreen extends StatefulWidget {
  const EncyclopediaScreen({super.key});

  @override
  _EncyclopediaScreenState createState() => _EncyclopediaScreenState();
}

class _EncyclopediaScreenState extends State<EncyclopediaScreen> {
  List<EncyclopediaRecord> _boxes = [];

  @override
  void initState() {
    super.initState();
    callApiSync();
  }

  Future<void> callApiSync() async {
    _boxes = await ApiRequests.fetchEncyclopediaData("");
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
              children: const <Widget>[
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
              ]);
        },
      ),
    );
  }
}
