import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front/screens/registration_screen.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;

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
                decoration: InputDecoration(labelText: 'Email'),
                validator: (input) => !input!.contains('@') ? 'Please enter a valid email' : null,
                onSaved: (input) => _email = input!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                validator: (input) => input!.length < 6 ? 'Must be at least 6 characters' : null,
                onSaved: (input) => _password = input!,
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Login'),
              ),
              ElevatedButton(
                onPressed: _navigateToRegistration,
                child: Text('Register'),
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

  void _submit() async {
    var url = 'http://10.0.2.2:5000//edit/encyclopedia';
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode({'position': 0, 'plant_description': "zmiana banana", 'search_input': ""}),
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
