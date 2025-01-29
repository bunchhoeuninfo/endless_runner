import 'dart:io';

import 'package:endless_runner/auth/data/player_data.dart';
import 'package:flutter/material.dart';

abstract class PlayerAuthManager {

  // --- Player Data Notifier
  //ValueNotifier<PlayerData> get playerDataNotifier;

  Future<PlayerData?> loadPlayerData();
  Future<void> savePlayerData(PlayerData playerData);
  Future<void> updatePlayerData(PlayerData updatedPlayerData);

  // Save profile image locally
  Future<String> saveProfileImgPath(File imgFile, String playerName);

  //Retrieve the local profile image path
  Future<String?> getProfileImgPath(String playerName);

  //Delete profile image by player name
  Future<void> deleteProfileImg(String playerName);

  // Save player settings
  Future<void> savePlayerSettings(PlayerData playerData);

  //Update player settings
  Future<void> updatePlayerSettings(PlayerData playerData);

  // Delete player data
  Future<void> deletePlayerData();

}