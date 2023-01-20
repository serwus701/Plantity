import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:front/screens/User/library_record_screen.dart';
import 'package:front/screens/User/library_screen.dart';
import 'package:http/http.dart' as http;

import '../../api_requests/user_api_requests.dart';
import '../../utils/encyclopedia_record.dart';

class DeletePage extends StatefulWidget {
  EncyclopediaRecord plant;
  String login;
  DeletePage({super.key, required this.plant, required this.login});

  @override
  _DeletePageState createState() => _DeletePageState(plant, login);
}

class _DeletePageState extends State<DeletePage> {
  final _formKey = GlobalKey<FormState>();
  EncyclopediaRecord plant;
  String login;
  _DeletePageState(this.plant, this.login);

  void deletePlant(EncyclopediaRecord plant, String login) async {
    await UserApiRequests.deletePlantFromLibrary(plant.plantNickname, plant.speciesName, login);
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
            Text('Deleting ${plant.plantNickname}',
                style: const TextStyle(
                  fontFamily: 'SourceSans3',
                  color: Colors.black,
                  fontSize: 25.0,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
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
                      Text(
                          'Are you sure you want to delete ${plant.plantNickname} from your library?',
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.black54),
              ),
              onPressed: () {
                deletePlant(plant, login);
              },
              child: const Text('Yes, delete'),
            ),
          ],
        ),
      ),
    );
  }

}
