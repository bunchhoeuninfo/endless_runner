import 'package:endless_runner/core/state/tree_surface_state.dart';
import 'package:flutter/material.dart';

abstract class TreeSurfaceStateManager {
  // --- Tree Surface State Management ---
  ValueNotifier<TreeSurfaceState> get stateNotifier;

  void changeState(TreeSurfaceState newState);
}