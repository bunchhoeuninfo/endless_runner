import 'package:endless_runner/auth/data/player_data.dart';
import 'package:endless_runner/core/managers/players/player_data_notifier_manager.dart';
import 'package:flutter/src/foundation/change_notifier.dart';

class PlayerDataNotifierService implements PlayerDataNotifierManager {

  // Singleton
  static final PlayerDataNotifierService _instance = PlayerDataNotifierService._internal();
  factory PlayerDataNotifierService() => _instance;
  PlayerDataNotifierService._internal();

  @override
  // TODO: implement playerDataNotifier
  ValueNotifier<PlayerData> playerDataNotifier = ValueNotifier<PlayerData>(PlayerData(playerName: 'Unknown', level: 1, topScore: 0, gender: 'Other', dateOfBirth: DateTime.parse(DateTime.now().toIso8601String().split('T').first), profileImgPath: null, settings: null)  );

}