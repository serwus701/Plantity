import 'dart:io';

import 'package:flutter/material.dart';
import 'package:front/api_requests/user_api_requests.dart';
import 'package:front/screens/User/encyclopedia_screen.dart';
import 'package:front/screens/User/library_record_screen.dart';
import 'package:front/utils/encyclopedia_record.dart';



class LibraryScreen extends StatefulWidget {
  String login;
  LibraryScreen({super.key, required this.login});

  @override
  _LibraryScreenState createState() => _LibraryScreenState(login);
}

class _LibraryScreenState extends State<LibraryScreen> {
  String login;
  _LibraryScreenState(this.login);
  List<EncyclopediaRecord> _boxes = [];


  @override
  void initState() {
    super.initState();
      callApiSync();
  }

  Future<void> callApiSync() async {
    _boxes = await UserApiRequests.fetchLibraryData(login); //ew zrzucic na id, ale luzno
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //callApiSync();
    return Scaffold(
      appBar: AppBar(
        title: Text('Library',
          style: TextStyle(
            fontFamily: 'SourceSans3',
            fontSize: 20.0,
            color: Colors.white,
            letterSpacing: 1.1,
          ),),
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
                      backgroundImage: AssetImage('assets/plants/${_boxes[index].photoId}.jpg'), //jak to zrobic?
                    ),
                  ),
                  Column(
                      children: <Widget> [
                        Text(
                          _boxes[index].plantNickname, //_boxes[index][0]
                          style: TextStyle(
                            fontFamily: 'SourceSans3',
                            fontSize: 25.0,
                            color: Colors.teal,
                            letterSpacing: 1.1,
                          ),
                        ),
                        Text(
                          _boxes[index].speciesName, //_boxes[index][2]
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black54,
                          ),
                        ),
                      ]
                  ),
                ]
            ),
            onTap: (){
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => LibraryRecord(plant: _boxes[index]))
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => EncyclopediaScreen(login: login))
          );
        },
        backgroundColor: Colors.lime,
        child: const Icon(Icons.add),
      ),
    );
  }

}
