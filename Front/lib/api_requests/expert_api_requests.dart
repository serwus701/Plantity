import 'package:front/utils/encyclopedia_record.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExpertApiRequest {
  static Future<bool> addPlantToEncyclopedia(
      String photoId,
      String speciesName,
      String speciesDescription,
      int howOftenToWater,
      int amountOfSun,
      int amountOfWater,
      int difficulty) async {
    var url = 'http://10.0.2.2:5000//add/encyclopedia';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'photo_id': photoId,
        'species_name': speciesName,
        'species_description': speciesDescription,
        'how_often_to_water': howOftenToWater,
        'amount_of_sun': amountOfSun,
        'amount_of_water': amountOfWater,
        'difficulty': difficulty,
      }),
    );

    bool answer = jsonDecode(response.body)['confirmation'];
    return answer;
  }

  static Future<bool> editPlantToEncyclopedia(String speciesName,String plantDescription) async {
    var url = 'http://10.0.2.2:5000//edit/encyclopedia';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'species_name': speciesName,
        'plant_description': plantDescription,
      }),
    );

    bool answer = jsonDecode(response.body)['confirmation'];
    return answer;
  }
}
