import 'package:flutter/material.dart';
import 'package:front/screens/Shared/delete_plant_screen.dart';
import 'package:front/screens/User/encyclopedia_record_screen.dart';

import '../../utils/encyclopedia_record.dart';
import '../User/encyclopedia_screen.dart';
import 'library_screen.dart';

class LibraryRecord extends StatefulWidget {
  String login;
  EncyclopediaRecord plant;
  LibraryRecord({super.key, required this.plant, required this.login});


  @override
  _LibraryRecordState createState() => _LibraryRecordState(plant, login);
}

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
  super.key,
  required this.label,
  required this.padding,
  required this.value,
  required this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label)),
            Checkbox(
              value: value,
              activeColor: Colors.lime,
              onChanged: (bool? newValue) {
                onChanged(newValue!);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LibraryRecordState extends State<LibraryRecord> {
  EncyclopediaRecord plant;
  String login;
  _LibraryRecordState(this.plant, this.login);
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text(plant.plantNickname,
              style: const TextStyle(
                fontFamily: 'SourceSans3',
                color: Colors.white,
                fontSize: 20.0,
                letterSpacing: 1.1,
              )),
          backgroundColor: Colors.teal,
        ),
      drawer: NavigationDrawer(login: login,),
        body: SafeArea(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: [
                          Text(
                            plant.plantNickname,
                            style: const TextStyle(
                              fontFamily: 'SourceSans3',
                              fontSize: 30.0,
                              color: Colors.teal,
                              letterSpacing: 1.1,
                            ),
                          ),
                          Text(
                            plant.speciesName,
                            style: const TextStyle(
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
                    margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
                    child: SizedBox(
                      width: 300,
                      height: 150,
                      child: Center(
                          child:  LabeledCheckbox(
                            label: 'Watered',
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            value: _isSelected,
                            onChanged: (bool newValue) {
                              setState(() {
                                _isSelected = newValue;
                              });
                            },
                          )
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                    child: SizedBox(
                      width: 300,
                      height: 250,
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
                          ),)
                      ),
                    ),
                  ),
              ],
            ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => DeletePage(login: login, plant: plant,))
            );
          },
          backgroundColor: Colors.lime,
          child: const Icon(Icons.delete),
    ),
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
