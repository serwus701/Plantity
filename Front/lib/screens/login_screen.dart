import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:front/screens/registration_screen.dart';

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

  void _submit(){

  }

/*
  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Make the login request to the backend
      var response = await http.post('https://your-backend-url.com/login', body: {
        'email': _email,
        'password': _password
      });

      // Check the response status code
      if (response.statusCode == 200) {
        // Login was successful
        // You can parse the response body to get the user's information
        var user = jsonDecode(response.body);

        // Save the user's information in the local storage or preferences
        // Navigate to the home page
      } else {
        // Login failed
        // Show an error message
      }
    }
  }*/
}
