

import 'package:endless_runner/auth/data/developer_profile.dart';

abstract class DeveloperProfileManager {
  Future<DeveloperProfile> loadProfileJson();
}