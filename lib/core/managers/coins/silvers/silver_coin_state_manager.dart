import 'package:endless_runner/core/state/silver_coin_state.dart';
import 'package:flutter/material.dart';

abstract class SilverCoinStateManager {
  // -- Silver coin state management --
  ValueNotifier<SilverCoinState> get stateNotifier;
  void changeState(SilverCoinState newState);
}