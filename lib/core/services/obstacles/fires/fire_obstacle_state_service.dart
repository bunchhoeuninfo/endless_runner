
import 'package:endless_runner/core/managers/obstacles/fires/fire_obstacle_state_manager.dart';
import 'package:endless_runner/core/state/fire_obstacle_state.dart';
import 'package:flutter/material.dart';

class FireObstacleStateService implements FireObstacleStateManager {

  // Singletone
  static final FireObstacleStateService _instance = FireObstacleStateService._internal();
  factory FireObstacleStateService() => _instance;
  FireObstacleStateService._internal();

  @override
  void changeState(FireObstacleState newState) {
    // TODO: implement changeState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      stateNotifier.value = newState;
    });
  }

  @override
  // TODO: implement stateNotifier
  ValueNotifier<FireObstacleState> stateNotifier = ValueNotifier<FireObstacleState>(FireObstacleState.idle);


}