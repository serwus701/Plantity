import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front/screens/library_screen.dart';
import 'package:front/screens/registration_screen.dart';
import 'package:http/http.dart' as http;

import 'encyclopedia.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String _login, _password;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: Form(
          key: _formKey,
          child: SafeArea(
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/start_plant.jpg'),
                ),
                Text(
                  'ᑭᒪᗩᑎTITY',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
                Text('TAKE CARE OF PLANTS EASILY',
                    style: TextStyle(
                      fontFamily: 'SourceSans3',
                      color: Colors.black,
                      fontSize: 15.0,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    )),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: TextFormField(
                    validator: (input) {
                      if (input!.isEmpty) {
                        return 'Please enter login';
                      }
                      return null;
                    },
                    onSaved: (input) => _login = input!,
                    decoration: InputDecoration(
                        labelText: '   Login',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.login,
                            color: Colors.teal
                          )
                        )),
                ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: TextFormField(
                    style: TextStyle(
                      decorationColor: Colors.teal,
                    ),
                    validator: (input) {
                      if (input!.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                    onSaved: (input) => _password = input!,
                    decoration: InputDecoration(
                        labelText: '   Password',
                        prefixIcon: Padding(
                        padding: EdgeInsets.all(0.0),
                      child: Icon(
                          Icons.password,
                          color: Colors.teal
                      )
                  )),
                    obscureText: true,
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.black54),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _submit(_login, _password);
                    }
                  },
                  child: Text('Login'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.black54),
                  ),
                  onPressed: () {
                    _navigateToRegistration();
                  },
                  child: Text('Don\'t have an account? Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToRegistration() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationPage()),
    );
  }

  void _navigateToUser() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScrollableBoxesPageL()),
    );
  }

  void _navigateToExpert() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationPage()),
    );
  }

  void _navigateToAdmin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationPage()),
    );
  }

  void _submit(String login, String password) async {
    //_navigateToUser();
    //return;
    var url = 'http://10.0.2.2:5000//login';
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode({'username': login, 'password': password}),
    );

    //print(response.statusCode);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data["approval"]);
      switch (data["approval"]) {
        case 1:
          {
            _navigateToUser();
            break;
          }
        case 2:
          {
            _navigateToExpert();
            break;
          }
        case 3:
          {
            _navigateToAdmin();
            break;
          }
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}
