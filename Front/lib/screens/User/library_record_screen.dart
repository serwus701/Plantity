import 'package:flutter/material.dart';
import 'package:front/screens/User/encyclopedia_record_screen.dart';

import '../../utils/encyclopedia_record.dart';

class LibraryRecord extends StatefulWidget {
  EncyclopediaRecord plant;
  LibraryRecord({super.key, required this.plant});


  @override
  _LibraryRecordState createState() => _LibraryRecordState(plant);
}

class _LibraryRecordState extends State<LibraryRecord> {
  EncyclopediaRecord plant;
  _LibraryRecordState(this.plant);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text(plant.plantNickname,
              style: TextStyle(
                fontFamily: 'SourceSans3',
                color: Colors.black,
                fontSize: 20.0,
                letterSpacing: 1.1,
              )),
          backgroundColor: Colors.teal,
        ),
        body: SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: [
                          Text(
                            plant.plantNickname,
                            style: TextStyle(
                              fontFamily: 'SourceSans3',
                              fontSize: 30.0,
                              color: Colors.teal,
                              letterSpacing: 1.1,
                            ),
                          ),
                          Text(
                            plant.speciesName,
                            style: TextStyle(
                              fontFamily: 'SourceSans3',
                              fontSize: 20.0,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage('assets/plants/${plant.photoId}.jpg'),
                      ),
                    ]
                ),
                Center(
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
                    child: SizedBox(
                      width: 300,
                      height: 150,
                      child: Center(
                          child: Text('Tu bedzie panel z checkboxami',
                              style: TextStyle(
                                fontFamily: 'SourceSans3',
                                color: Colors.black,
                                fontSize: 11.0,
                                letterSpacing: 1.1,
                              ))
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
                    child: SizedBox(
                      width: 300,
                      height: 250,
                      child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(plant.speciesDescription,
                                style: TextStyle(
                                  fontFamily: 'SourceSans3',
                                  color: Colors.black,
                                  fontSize: 11.0,
                                  letterSpacing: 1.1,
                                )),
                          ),)
                      ),
                    ),
                  ),
              ],
            )
        )
    );
  }
}
