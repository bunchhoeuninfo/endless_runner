import 'package:endless_runner/core/state/player_state.dart';
import 'package:flutter/material.dart';

abstract class PlayerStateManager {
  // --- Player State Management ---
  ValueNotifier<PlayerState> get stateNotifier;

  void changeState(PlayerState newState);
}