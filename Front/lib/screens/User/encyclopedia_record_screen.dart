import 'package:flutter/material.dart';
import 'package:front/screens/Admin/delete_encyclopedia_record_screen.dart';
import 'package:front/screens/Shared/delete_plant_screen.dart';
import 'package:front/screens/Shared/library_screen.dart';

import '../../api_requests/user_api_requests.dart';
import '../../utils/encyclopedia_record.dart';
import '../Shared/add_plant_screen.dart';
import 'package:front/globals.dart' as globals;

import 'encyclopedia_screen.dart';

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
        drawer: NavigationDrawer(login: login,),
        body: ListView(
          children: <Widget> [
            Column(
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        plant.speciesName,
                        style: const TextStyle(
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
                    margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
                    child: SizedBox(
                      width: 300,
                      height: 150,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget> [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget> [
                                    Text('Water:  ',
                                      style: const TextStyle(
                                        fontFamily: 'SourceSans3',
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        letterSpacing: 1.1,
                                      ),),
                                    for (var i =0; i < plant.amountOfWater; i++)
                                      Padding(padding: EdgeInsets.all(2.0),
                                        child: Icon(Icons.water_drop_rounded)),
                                    for (var i = 5; i - plant.amountOfWater > 0; i--)
                                      Padding(padding: EdgeInsets.all(2.0),
                                          child: Icon(Icons.water_drop_outlined)),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget> [
                                  Text('Sun:  ',
                                    style: const TextStyle(
                                      fontFamily: 'SourceSans3',
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      letterSpacing: 1.1,
                                    ),),
                                  for (var i =0; i < plant.amountOfSun; i++)
                                    Padding(padding: EdgeInsets.all(2.0),
                                        child: Icon(Icons.wb_sunny)),
                                  for (var i = 5; i - plant.amountOfSun > 0; i--)
                                    Padding(padding: EdgeInsets.all(2.0),
                                        child: Icon(Icons.wb_sunny_outlined)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget> [
                                  Text('Difficulty:  ',
                                    style: const TextStyle(
                                      fontFamily: 'SourceSans3',
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      letterSpacing: 1.1,
                                    ),),
                                  for (var i =0; i < plant.difficulty; i++)
                                    Padding(padding: EdgeInsets.all(2.0),
                                        child: Icon(Icons.volunteer_activism)),
                                  for (var i = 5; i - plant.difficulty > 0; i--)
                                    Padding(padding: EdgeInsets.all(2.0),
                                        child: Icon(Icons.volunteer_activism_outlined)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
                    child: SizedBox(
                      width: 300,
                      height: 200,
                      child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(plant.speciesDescription,
                                style: const TextStyle(
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
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.black54),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => AddPage(plant: plant, login: login))
                    );
                  },
                  child: const Text('Add to your library'),
                ),
                if(globals.user_type == 'admin') ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.black54),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => DeleteEnyclopediaPage(plant: plant, login: login))
                    );
                  },
                  child: const Text('Delete from encyclopedia'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                if(globals.user_type == 'expert') ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.black54),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => AddPage(plant: plant, login: login))
                    );
                  },
                  child: const Text('Modify record'),
                ),

              ],
            ),
          ]
        )
    );
  }
}

class NavigationDrawer extends StatefulWidget {
  String login;
  NavigationDrawer({super.key, required this.login});

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState(login);

}

class _NavigationDrawerState extends State<NavigationDrawer>{
  late String login;
  _NavigationDrawerState(this.login);

  @override
  Widget build(BuildContext context) => Drawer(
      child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(context),
              buildMenuItems(context),
            ],

          )
      )
  );
  Widget buildHeader(BuildContext context) => Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      )
  );

  Widget buildMenuItems(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    child: Wrap(
      runSpacing: 16,
      children: [
        ListTile(
          leading: const Icon(Icons.spa),
          title: const Text('Library'),
          onTap: () =>
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LibraryScreen(login: login))
              ),
        ),
        ListTile(
          leading: const Icon(Icons.menu_book),
          title: const Text('Encyclopedia'),
          onTap: () =>
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EncyclopediaScreen(login: login)),
              ),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Profile'),
          onTap: () {},
        ),
      ],
    ),
  );

}