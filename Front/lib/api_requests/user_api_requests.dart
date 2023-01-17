import 'package:front/utils/encyclopedia_record.dart';
import 'package:front/utils/user_data_record.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ApiRequests {
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

  static Future<List<EncyclopediaRecord>> fetchEncyclopediaData(String searchText) async {
    List<EncyclopediaRecord> encyclopediaRecords = [];

    var url = 'http://10.0.2.2:5000//get/encyclopedia';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'search_text': searchText,
      }),
    );
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
        for (var i = 0; i < data["photo_id"].length; i++) {
          var record = EncyclopediaRecord(
              "",
              data["photo_id"][i],
              data["species_name"][i],
              data["species_description"][i],
              data["how_often_to_water"][i],
              data["amount_of_sun"][i],
              data["amount_of_water"][i],
              data["difficulty"][i]);
          encyclopediaRecords.add(record);
        }
        return encyclopediaRecords;
    } else {
      throw Exception('Failed to load boxes');
    }
  }

  static Future<List<EncyclopediaRecord>> fetchLibraryData(String userLogged) async {
    List<EncyclopediaRecord> libraryRecords = [];

    var url = 'http://10.0.2.2:5000//get/library';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'user_logged': userLogged,
      }),
    );
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
        for (var i = 0; i < data["photo_id"].length; i++) {
          var record = EncyclopediaRecord(
              data["plant_name"][i],
              data["photo_id"][i],
              data["species_name"][i],
              data["species_description"][i],
              data["how_often_to_water"][i],
              data["amount_of_sun"][i],
              data["amount_of_water"][i],
              data["difficulty"][i]);
          libraryRecords.add(record);
        }
        return libraryRecords;
    } else {
      throw Exception('Failed to load boxes');
    }
  }

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
}
