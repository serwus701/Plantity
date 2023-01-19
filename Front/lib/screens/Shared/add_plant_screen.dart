import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:front/screens/User/library_record_screen.dart';
import 'package:front/screens/User/library_screen.dart';
import 'package:http/http.dart' as http;

import '../../api_requests/user_api_requests.dart';
import '../../utils/encyclopedia_record.dart';

class AddPage extends StatefulWidget {
  EncyclopediaRecord plant;
  String login;
  AddPage({super.key, required this.plant, required this.login});

  @override
  _AddPageState createState() => _AddPageState(plant, login);
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  EncyclopediaRecord plant;
  String login;
  _AddPageState(this.plant, this.login);

  void addPlant(EncyclopediaRecord plant, String login) async {
    await UserApiRequests.addPlantToLibrary(plant.plantNickname, plant.speciesName, login);
    setState(() {});
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LibraryScreen(login: login))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/plants/${plant.photoId}.jpg'),
              ),
            ),
            Text('Add new ${plant.speciesName}',
                style: TextStyle(
                  fontFamily: 'SourceSans3',
                  color: Colors.black,
                  fontSize: 25.0,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  color:Colors.tealAccent,
                )
            ),
            Container(
              color: Colors.teal,
              child: AlertDialog(
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        validator: (input) {
                          if (input!.isEmpty) {
                            return 'Please enter your new plant name';
                          }
                          return null;
                        },
                        onChanged: (input) => plant.plantNickname = input, //nie wiem czy to dobrze, bo tworzymy chyba nowy obiekt
                        decoration: InputDecoration(labelText: 'Plant name'),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.black54),
              ),
              onPressed: () {
                addPlant(plant, login);
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

}
