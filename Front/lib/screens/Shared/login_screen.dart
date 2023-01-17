import 'package:flutter/material.dart';
import 'package:front/screens/User/encyclopedia_screen.dart';
import 'package:front/screens/User/library_screen.dart';
import 'package:front/screens/Shared/registration_screen.dart';
import 'package:front/api_requests/user_api_requests.dart';


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
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
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
                            child: Icon(Icons.login, color: Colors.teal))),
                  ),
                ),
                Card(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
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
                            child: Icon(Icons.password, color: Colors.teal))),
                    obscureText: true,
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.black54),
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
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.black54),
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
      MaterialPageRoute(builder: (context) => LibraryScreen()),
    );
  }

  void _navigateToExpert() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EncyclopediaScreen()),
    );
  }

  void _navigateToAdmin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationPage()),
    );
  }

  void _submit(String login, String password) async {
    var login_result = await ApiRequests.loginSubmit(_login, _password);

    switch (login_result) {
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
  }
}
