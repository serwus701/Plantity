import 'package:flutter/material.dart';
import 'package:front/api_requests/user_api_requests.dart';
import 'package:front/screens/User/encyclopedia_record_screen.dart';
import 'package:front/utils/encyclopedia_record.dart';
import 'package:front/globals.dart' as globals;
import '../../api_requests/shared_api_requests.dart';
import '../Expert/encyclopedia_expert_screen.dart';


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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Encyclopedia'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: _boxes.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage('assets/plants/${_boxes[index].photoId}.jpg'),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      _boxes[index].speciesName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'SourceSans3',
                        fontSize: 25.0,
                        color: Colors.black87,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ]
            ),
              onTap: (){
                switch (globals.user_type) {
                  case 'user':
                    {
                      globals.user_type = 'user';
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => EncyclopediaRecordScreen(plant: _boxes[index], login: login,))
                      );
                      break;
                    }
                  case 'expert':
                    {
                      globals.user_type = 'expert';
                      globals.user_type = 'user';
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => EncyclopediaExpertRecordScreen(plant: _boxes[index], login: login,))
                      );
                      break;
                    }
                  case 'admin':
                    {
                      globals.user_type = 'admin';
                      globals.user_type = 'user';
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => EncyclopediaRecordScreen(plant: _boxes[index], login: login,))
                      );
                      break;
                    }
                }
              }
          );
        },
      ),
    );
  }
}
