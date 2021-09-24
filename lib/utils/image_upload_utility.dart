// the code below is used to create a class for converting the
// image to base 64 and then as a string
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageUploadUtility {
  // the code below is used to create a method for getting the
  // image from base 64 from the memory and showing that to the user
  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  // the code below is used to create a function to decode the data from a
  // base64 string to a unit 8 list
  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  // the code below is used to create a function to encode the data
  // into base64 string
  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
