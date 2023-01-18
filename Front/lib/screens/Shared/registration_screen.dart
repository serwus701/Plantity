import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  late String _login, _password, _firstname, _lastname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text('REGISTER',
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
                            return 'Please enter your Firstname';
                          }
                          return null;
                        },
                        onChanged: (input) => _firstname = input,
                        decoration: InputDecoration(labelText: 'Firstname'),
                      ),
                      TextFormField(
                        validator: (input) {
                          if (input!.isEmpty) {
                            return 'Please enter your Lastname';
                          }
                          return null;
                        },
                        onChanged: (input) => _lastname = input,
                        decoration: InputDecoration(labelText: 'Lastname'),
                      ),
                      TextFormField(
                        validator: (input) {
                          if (input!.isEmpty) {
                            return 'Please enter Login';
                          }
                          return null;
                        },
                        onChanged: (input) => _login = input,
                        decoration: InputDecoration(labelText: 'Login'),
                      ),
                      TextFormField(
                        validator: (input) {
                          if (input!.isEmpty) {
                            return 'Please enter a your password';
                          }
                          return null;
                        },
                        onChanged: (input) => _password = input,
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
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
                _submit(_login, _password, _firstname, _lastname);
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  void _submit(
      String login, String password, String firstname, String lastname) async {
    print(login + password);
    var url = 'http://10.0.2.2:5000//register';
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'username': _login,
        'password': password,
        'firstname': firstname,
        'lastname': lastname
      }),
    );

    var data = json.decode(response.body);
    print(data["approval"]);
  }
}
