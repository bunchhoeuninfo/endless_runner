import 'package:endless_runner/core/managers/surfacelands/trees/tree_surface_state_manager.dart';
import 'package:endless_runner/core/state/tree_surface_state.dart';
import 'package:flutter/material.dart';

class TreeSurfaceStateService implements TreeSurfaceStateManager {

  // Singleton
  static final TreeSurfaceStateService _instance = TreeSurfaceStateService._internal();
  factory TreeSurfaceStateService() => _instance;
  TreeSurfaceStateService._internal();

  @override
  void changeState(TreeSurfaceState newState) {
    // TODO: implement changeState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      stateNotifier.value = newState;
    });
  }

  @override
  // TODO: implement stateNotifier
  ValueNotifier<TreeSurfaceState> stateNotifier = ValueNotifier<TreeSurfaceState>(TreeSurfaceState.idle);

}