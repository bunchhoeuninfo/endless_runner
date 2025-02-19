import 'package:endless_runner/core/managers/players/player_state_manager.dart';
import 'package:endless_runner/core/state/player_state.dart';
import 'package:flutter/material.dart';

class PlayerStateService implements PlayerStateManager {

  // Singleton
  static final PlayerStateService _instance = PlayerStateService._internal();
  factory PlayerStateService() => _instance;
  PlayerStateService._internal();

  @override
  void changeState(PlayerState newState) {
    // TODO: implement changeState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      stateNotifier.value = newState;
    });
  }

  @override
  // TODO: implement stateNotifier
  ValueNotifier<PlayerState> stateNotifier = ValueNotifier<PlayerState>(PlayerState.idle);

}