import 'package:endless_runner/core/managers/powerups/rocket_booster_state_manager.dart';
import 'package:endless_runner/core/state/rocket_booster_state.dart';
import 'package:flutter/material.dart';


class RocketBoosterStateService implements RocketBoosterStateManager {

  // Singletone
  static final RocketBoosterStateService _instance = RocketBoosterStateService._internal();
  factory RocketBoosterStateService() => _instance;
  RocketBoosterStateService._internal();

  @override
  void changeState(RocketBoosterState newState) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      stateNotifier.value = newState;
    });
  }

  @override  
  ValueNotifier<RocketBoosterState> stateNotifier = ValueNotifier<RocketBoosterState>(RocketBoosterState.idle);

}