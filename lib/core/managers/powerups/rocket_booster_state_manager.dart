
import 'package:endless_runner/core/state/rocket_booster_state.dart';
import 'package:flutter/material.dart';

abstract class RocketBoosterStateManager {
  // -- Rocket booster state management --
  ValueNotifier<RocketBoosterState> get stateNotifier;
  void changeState(RocketBoosterState newState);
}