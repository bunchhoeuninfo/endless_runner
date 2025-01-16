import 'dart:convert';

import 'package:endless_runner/auth/data/developer_profile.dart';
import 'package:endless_runner/auth/managers/developer_profile_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class DeveloperProfileService implements DeveloperProfileManager {

  final Logger _logger = Logger();
  final String _className = 'DeveloperProfilerService';
  final String _devProfileJson = 'assets/data/developer_profile.json';

  @override
  Future<DeveloperProfile> loadProfileJson() async {
    if (kDebugMode) _logger.d('Start inside $_className.loadProfileJson ...');

    try {
      final String jsonString = await rootBundle.loadString(_devProfileJson);
      final Map<String, dynamic> jsonData = json.decode(jsonString);      
      return DeveloperProfile.fromMap(jsonData);
    } catch (e) {
      _logger.d('Exception -> $e');
      return DeveloperProfile(name: 'name', title: 'title', expertise: 'expertise', bio: 'bio', imageUrl: 'imageUrl', email:'bunchhoeun.chhim@gmail.com');
    }    
  }
}