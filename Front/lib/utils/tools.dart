import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'dart:io';

Image base64ToImage(String base64String) {
  return Image.memory(
    base64Decode(base64String),
    fit: BoxFit.fill,
  );
}

String imageToBase64(File image) {
  return base64Encode(image.readAsBytesSync());
}