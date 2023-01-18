import 'package:flutter/material.dart';
import 'package:front/screens/User/library_screen.dart';

import '../../api_requests/user_api_requests.dart';
import '../../utils/encyclopedia_record.dart';
import '../Shared/add_plant_screen.dart';

class EncyclopediaRecordScreen extends StatefulWidget {
  EncyclopediaRecord plant;
  String login;
  EncyclopediaRecordScreen({super.key, required this.plant, required this.login});

  @override
  _EncyclopediaRecordScreenState createState() => _EncyclopediaRecordScreenState(plant, login);
}

class _EncyclopediaRecordScreenState extends State<EncyclopediaRecordScreen> {
  EncyclopediaRecord plant;
  String login;
  _EncyclopediaRecordScreenState(this.plant, this.login);

  @override
  void initState() {
    super.initState();
  }

  void addPlant(EncyclopediaRecord plant) async {
    UserApiRequests.addPlantToLibrary(plant.plantNickname, plant.speciesName, login);
    //setState(() {});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LibraryScreen(login: login)),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text(plant.speciesName),
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
                      Text(
                        plant.speciesName,
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.teal,
                        ),
                      ),
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage('assets/plants/${plant.photoId}.jpg'),
                      ),
                    ]
                ),
                Center(
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                    child: SizedBox(
                      width: 300,
                      height: 150,
                      child: Center(
                          child: Text('Tu bedzie panel z podstawowymi info')
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
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
                                  fontSize: 12.0,
                                  letterSpacing: 1.1,
                                )),
                          )
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.black54),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => AddPage(plant: plant, login: login))
                    );
                  },
                  child: Text('Add to your library'),
                ),
              ],
            )
        )
    );
  }
}