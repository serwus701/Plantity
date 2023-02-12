import 'dart:convert';
import 'dart:math';
import 'package:front/api_requests/shared_api_requests.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'library_screen.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  late String _login, _password;

  void changePassword(String login, String oldPassword, String newPassword) async {
    await SharedApiRequests.changePassword(login, oldPassword, newPassword);
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
            const Text('CHANGE PASSWORD',
                style: TextStyle(
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
                      TextFormField(
                        validator: (input) {
                          if (input!.isEmpty) {
                            return 'Please enter new password';
                          }
                          return null;
                        },
                        onChanged: (input) => _password = input,
                        decoration: const InputDecoration(labelText: 'New password'),
                      ),
                      TextFormField(
                        validator: (input) {
                          if (input!.isEmpty) {
                            return 'Please enter your new password';
                          }
                          return null;
                        },
                        onChanged: (input) => _password = input,
                        decoration: const InputDecoration(labelText: 'New password'),
                        obscureText: true,
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
                changePassword(_login, _password, _password);
              },
              child: const Text('Change password'),
            ),
          ],
        ),
      ),
    );
  }

}
