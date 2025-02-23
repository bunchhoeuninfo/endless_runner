import 'package:endless_runner/components/surfacetoland/stone_surface_to_land.dart';
import 'package:endless_runner/core/managers/surfacelands/stones/stone_surface_to_land_state_manager.dart';
import 'package:endless_runner/core/state/stone_surface_to_land_state.dart';
import 'package:flutter/material.dart';


class StoneSurfaceToLandStateService implements StoneSurfaceToLandStateManager {
  // Singletone

  static final StoneSurfaceToLandStateService _instance = StoneSurfaceToLandStateService._internal();
  factory StoneSurfaceToLandStateService() => _instance;
  StoneSurfaceToLandStateService._internal();

  @override
  void changeState(StoneSurfaceToLandState newState) {
    // TODO: implement changeState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      stateNotifier.value = newState;
    });
  }

  @override
  // TODO: implement stateNotifier
  ValueNotifier<StoneSurfaceToLandState>  stateNotifier = ValueNotifier<StoneSurfaceToLandState>(StoneSurfaceToLandState.idle);

}