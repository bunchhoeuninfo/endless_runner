import 'package:endless_runner/core/state/tree_surface_to_land_state.dart';
import 'package:flutter/material.dart';

abstract class TreeSurfaceToLandStateManager {
  // --- Tree Surface State Management ---
  ValueNotifier<TreeSurfaceToLandState> get stateNotifier;

  void changeState(TreeSurfaceToLandState newState);
}