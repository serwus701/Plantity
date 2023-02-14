import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:front/screens/Shared/library_record_screen.dart';
import 'package:front/screens/Shared/library_screen.dart';
import 'package:front/screens/User/encyclopedia_screen.dart';
import 'package:http/http.dart' as http;

import '../../api_requests/admin_api_requests.dart';
import '../../utils/encyclopedia_record.dart';

class DeleteEnyclopediaPage extends StatefulWidget {
  EncyclopediaRecord plant;
  String login;
  DeleteEnyclopediaPage({super.key, required this.plant, required this.login});

  @override
  _DeleteEnyclopediaPageState createState() => _DeleteEnyclopediaPageState(plant, login);
}

class _DeleteEnyclopediaPageState extends State<DeleteEnyclopediaPage> {
  final _formKey = GlobalKey<FormState>();
  EncyclopediaRecord plant;
  String login;
  _DeleteEnyclopediaPageState(this.plant, this.login);

  void deleteSpecies(String speciesName) async {
    await AdminApiRequests.deleteEncyclopediaRecord(plant.speciesName);
    setState(() {});
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EncyclopediaScreen(login: login))
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
            Text('Deleting ${plant.speciesName}',
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
                        'Are you sure you want to delete ${plant.speciesName} from your library?',
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
                deleteSpecies(plant.speciesName);
              },
              child: const Text('Yes, delete'),
            ),
          ],
        ),
      ),
    );
  }

}
