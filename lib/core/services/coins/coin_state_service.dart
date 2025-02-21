import 'package:endless_runner/core/managers/coins/coin_state_manager.dart';
import 'package:endless_runner/core/state/coin_state.dart';
import 'package:flutter/material.dart';

class CoinStateService implements CoinStateManager {

  // Singleton
  static final CoinStateService _instance = CoinStateService._internal();
  factory CoinStateService() => _instance;
  CoinStateService._internal();

  @override
  void changeState(CoinState newState) {
    // TODO: implement changeState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      stateNotifier.value = newState;
    });
  }

  @override
  // TODO: implement stateNotifier
  ValueNotifier<CoinState> stateNotifier = ValueNotifier<CoinState> (CoinState.idle);

}