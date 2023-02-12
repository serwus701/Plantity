import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../utils/tools.dart';


class ExpertApiRequest {
  static Future<bool> addPlantToEncyclopedia(
      String photoId,
      File photo,
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
        'photo': imageToBase64(photo),
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
