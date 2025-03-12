
import 'package:endless_runner/core/managers/backgrounds/grids/grid_background_state_manager.dart';
import 'package:endless_runner/core/state/grid_background_state.dart';
import 'package:flutter/material.dart';

class GridBackgroundStateService implements GridBackgroundStateManager {

  // Singletone

  static final GridBackgroundStateService _instance = GridBackgroundStateService._internal();
  factory GridBackgroundStateService() => _instance;
  GridBackgroundStateService._internal();

  @override
  void changeState(GridBackgroundState newState) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      stateNotifier.value = newState;
    });
  }

  @override
  // TODO: implement stateNotifier
  ValueNotifier<GridBackgroundState> stateNotifier = ValueNotifier<GridBackgroundState>(GridBackgroundState.idle);

}