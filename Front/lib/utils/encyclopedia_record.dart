import 'package:flutter/widgets.dart';

class EncyclopediaRecord {
  String plantNickname;
  String photoId;
  Image photo;
  String speciesName;
  String speciesDescription;
  int howOftenToWater;
  int amountOfSun;
  int amountOfWater;
  int difficulty;

  EncyclopediaRecord(
      this.plantNickname,
      this.photoId,
      this.photo,
      this.speciesName,
      this.speciesDescription,
      this.howOftenToWater,
      this.amountOfSun,
      this.amountOfWater,
      this.difficulty);


}
