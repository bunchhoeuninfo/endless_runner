import 'package:endless_runner/core/managers/surfacelands/trees/tree_surface_to_land_state_manager.dart';
import 'package:endless_runner/core/state/tree_surface_to_land_state.dart';
import 'package:flutter/material.dart';

class TreeSurfaceToLandStateService implements TreeSurfaceToLandStateManager {

  // Singleton
  static final TreeSurfaceToLandStateService _instance = TreeSurfaceToLandStateService._internal();
  factory TreeSurfaceToLandStateService() => _instance;
  TreeSurfaceToLandStateService._internal();



  @override
  // TODO: implement stateNotifier
  ValueNotifier<TreeSurfaceToLandState> stateNotifier = ValueNotifier<TreeSurfaceToLandState>(TreeSurfaceToLandState.idle);
  
  @override
  void changeState(TreeSurfaceToLandState newState) {
    // TODO: implement changeState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      stateNotifier.value = newState;
    });
  }

}