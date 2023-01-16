import 'dart:convert';

import 'package:flutter/material.dart';
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
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/roslinka.jpg'),
        fit: BoxFit.cover,
      )),
      child: AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                validator: (input) {
                  if (input!.isEmpty) {
                    return 'Please enter login';
                  }
                  return null;
                },
                onSaved: (input) => _login = input!,
                decoration: InputDecoration(labelText: 'Login'),
              ),
              TextFormField(
                validator: (input) {
                  if (input!.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                onSaved: (input) => _password = input!,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _submit(_login, _password);
                  }
                },
                child: Text('Login'),
              ),
              ElevatedButton(
                onPressed: () {
                  _navigateToRegistration();
                },
                child: Text('Don\'t have an account? Register'),
              ),
            ],
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
      MaterialPageRoute(builder: (context) => ScrollableBoxesPage()),
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
    _navigateToUser();
    return;
    var url = 'http://10.0.2.2:5000/login';
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode({'username': login, 'password': password}),
    );

    //print(response.statusCode);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

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
