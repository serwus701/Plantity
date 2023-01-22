import 'package:front/utils/user_data_record.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AdminApiRequests {
  static Future<List<UserDataRecord>> fetchUserData(String searchText) async {
    List<UserDataRecord> libraryRecords = [];

    var url = 'http://10.0.2.2:5000//get/user';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'search_text': searchText,
      }),
    );
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      for (var i = 0; i < data["user_login"].length; i++) {
        var record = UserDataRecord(
            data["firstname"][i],
            data["lastname"][i],
            data["user_login"][i],
            data["is_expert"][i]);
        libraryRecords.add(record);
      }
      return libraryRecords;
    } else {
      throw Exception('Failed to load boxes');
    }
  }

  static Future<bool> editIfExpert(String userLogin) async {

    var url = 'http://10.0.2.2:5000//edit/user';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'user_login': userLogin,
      }),
    );

      bool answer = jsonDecode(response.body)['confirmation'];
      return answer;
  }

  static Future<bool> deleteClient(String userLogin) async {

    var url = 'http://10.0.2.2:5000//delete/user';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'user_login': userLogin,
      }),
    );

    bool answer = jsonDecode(response.body)['confirmation'];
    return answer;
  }

  static Future<bool> deleteEncyclopediaRecord(String speciesName) async {

    var url = 'http://10.0.2.2:5000//delete/encyclopedia';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'species_name': speciesName,
      }),
    );

    bool answer = jsonDecode(response.body)['confirmation'];
    return answer;
  }
}