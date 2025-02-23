import 'dart:convert';

import 'package:flutter/services.dart';

class ImageAssetConstant {
  static List<String> _imgAssetNames = [];

  // Priate constructor to prevent instantiation
  ImageAssetConstant._();

  // Load assets from JSON file (call this once in main or initState)
  static Future<void> loadImgAssets() async {
    final String response = await rootBundle.loadString('assets/img_asset_names.json');
    final Map<String, dynamic> data = jsonDecode(response);
    _imgAssetNames = List<String>.from(data['imgAssetNames']);
  }

  // Get loaded asset names
  static List<String> get imgAssetNames => _imgAssetNames;
}