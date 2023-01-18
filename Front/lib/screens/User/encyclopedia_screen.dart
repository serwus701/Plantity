import 'package:flutter/material.dart';
import 'package:front/api_requests/user_api_requests.dart';
import 'package:front/screens/User/encyclopedia_record_screen.dart';
import 'package:front/utils/encyclopedia_record.dart';


class EncyclopediaScreen extends StatefulWidget {
  String login;
  EncyclopediaScreen({super.key, required this.login});

  @override
  _EncyclopediaScreenState createState() => _EncyclopediaScreenState(login);
}

class _EncyclopediaScreenState extends State<EncyclopediaScreen> {
  String login;
  _EncyclopediaScreenState(this.login);
  List<EncyclopediaRecord> _boxes = [];

  @override
  void initState() {
    super.initState();
    callApiSync();
  }

  void callApiSync() async {
    _boxes = await UserApiRequests.fetchEncyclopediaData("");
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    callApiSync();
    return Scaffold(
      appBar: AppBar(
        title: Text('Encyclopedia'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: _boxes.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage('assets/plants/${_boxes[index].photoId}.jpg'),
                    ),
                  ),
                  Text(
                    _boxes[index].speciesName,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black87,
                    ),
                  ),
                ]
            ),
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => EncyclopediaRecordScreen(plant: _boxes[index], login: login,))
                );
              }
          );
        },
      ),
    );
  }
}
