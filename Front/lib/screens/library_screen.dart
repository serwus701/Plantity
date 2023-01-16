import 'package:flutter/material.dart';

class ScrollableBoxesPageL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scrollable Boxes/Library'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/start_plant.jpg'),
                ),
                Column(
                  children: <Widget> [
                    Text(
                      'Plant name',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.teal,
                      ),
                    ),
                    Text(
                      'Plant species',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black54,
                      ),
                    ),
                  ]
                ),
              ]
          );
        },
      ),
    );
  }
}