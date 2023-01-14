import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name, _lastName, _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (input) => input!.isEmpty ? 'Name is required' : null,
                onSaved: (input) => _name = input!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (input) => input!.isEmpty ? 'Last Name is required' : null,
                onSaved: (input) => _lastName = input!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (input) => !input!.contains('@') ? 'Please enter a valid email' : null,
                onSaved: (input) => _email = input!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                validator: (input) => input!.length < 6 ? 'Password must be at least 6 characters' : null,
                onSaved: (input) => _password = input!,
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Perform registration
    }
  }
}