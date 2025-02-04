import 'package:endless_runner/auth/data/player_data.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

abstract class PlayerDataNotifierManager {
  ValueNotifier<PlayerData> get playerDataNotifier;
}