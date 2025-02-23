import 'package:endless_runner/components/obstacles/fire_obstacle.dart';
import 'package:endless_runner/core/state/fire_obstacle_state.dart';
import 'package:flutter/material.dart';

abstract class FireObstacleStateManager {
  // -- Fire obstacle state management --
  ValueNotifier<FireObstacleState> get stateNotifier;
  void changeState(FireObstacleState newState);
}