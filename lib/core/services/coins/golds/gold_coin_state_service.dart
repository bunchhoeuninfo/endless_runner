
import 'package:endless_runner/core/managers/coins/golds/gold_coin_state_manager.dart';
import 'package:endless_runner/core/state/gold_coin_state.dart';
import 'package:flutter/material.dart';

class GoldCoinStateService implements GoldCoinStateManager {

  // Singletone
  static final GoldCoinStateService _instance = GoldCoinStateService._internal();
  factory GoldCoinStateService() => _instance;
  GoldCoinStateService._internal();

  @override
  void changeState(GoldCoinState newState) {
    // TODO: implement changeState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      stateNotifier.value = newState;
    });
  }

  @override
  // TODO: implement stateNotifier
  ValueNotifier<GoldCoinState> stateNotifier = ValueNotifier<GoldCoinState> (GoldCoinState.idle);

}