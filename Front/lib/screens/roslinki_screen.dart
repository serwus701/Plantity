import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Roslinki')),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/roslinka.jpg'),
                fit: BoxFit.cover,
              )),
          child: Center(
              child: Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white70),
                  child: Text(
                    'Hello there !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      shadows: [
                        Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 2.0,
                            color: Colors.green)
                      ],
                    ),
                  )))),
    );
  }
}
