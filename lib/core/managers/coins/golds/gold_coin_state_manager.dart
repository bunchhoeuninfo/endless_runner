import 'package:endless_runner/components/coins/gold_coin.dart';
import 'package:endless_runner/core/state/gold_coin_state.dart';
import 'package:flutter/material.dart';

abstract class GoldCoinStateManager {
  // -- Gold coin state management --
  ValueNotifier<GoldCoinState> get stateNotifier;
  void changeState(GoldCoinState newState);
}