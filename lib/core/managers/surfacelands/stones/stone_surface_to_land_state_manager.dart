import 'package:endless_runner/components/surfacetoland/stone_surface_to_land.dart';
import 'package:endless_runner/core/state/stone_surface_to_land_state.dart';
import 'package:flutter/material.dart';

abstract class StoneSurfaceToLandStateManager {
  // -- Stone Surface to land state manager --
  ValueNotifier<StoneSurfaceToLandState> get stateNotifier;
  void changeState(StoneSurfaceToLandState newState);
}