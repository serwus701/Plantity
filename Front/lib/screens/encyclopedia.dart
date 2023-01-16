import 'package:flutter/material.dart';

class ScrollableBoxesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scrollable Boxes'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.grey[300], borderRadius: BorderRadius.circular(10.0)),
            child: Text('Box $index'),
          );
        },
      ),
    );
  }
}