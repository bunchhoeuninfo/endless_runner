
import 'package:endless_runner/core/state/grid_background_state.dart';
import 'package:flutter/material.dart';

abstract class GridBackgroundStateManager {
  // -- Grid background state manager --
  ValueNotifier<GridBackgroundState> get stateNotifier;
  void changeState(GridBackgroundState newState);
  
}