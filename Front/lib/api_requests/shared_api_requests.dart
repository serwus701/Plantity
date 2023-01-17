import 'dart:convert';
import 'package:http/http.dart' as http;

class SharedApiRequests {
  static Future<int> loginSubmit(String login, String password) async {
    var url = 'http://10.0.2.2:5000//login';
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode({'username': login, 'password': password}),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      return data["approval"];
    } else {
      throw Exception('Failed to load data');
    }
  }
}
