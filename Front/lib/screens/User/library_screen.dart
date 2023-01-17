import 'package:flutter/material.dart';
import 'package:front/api_requests/user_api_requests.dart';
import 'package:front/utils/encyclopedia_record.dart';



class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  List<EncyclopediaRecord> _boxes = [];
  String userLogged = "slaby_gracz";

  @override
  void initState()  {
    super.initState();
      callApiSync();
  }

  Future<void> callApiSync() async {
    _boxes = await UserApiRequests.fetchLibraryData("slaby_gracz");
  }

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
                const CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/start_plant.jpg'),
                ),
                Column(children: const <Widget>[
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
                ]),
              ]);
        },
      ),
    );
  }

}
