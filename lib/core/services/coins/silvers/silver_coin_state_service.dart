import 'package:endless_runner/core/managers/coins/silvers/silver_coin_state_manager.dart';
import 'package:endless_runner/core/state/silver_coin_state.dart';
import 'package:flutter/material.dart';

class SilverCoinStateService implements SilverCoinStateManager {

  // Singletone
  static final SilverCoinStateService _instance = SilverCoinStateService._internal();
  factory SilverCoinStateService() => _instance;
  SilverCoinStateService._internal();

  @override
  void changeState(SilverCoinState newState) {
    // TODO: implement changeState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      stateNotifier.value = newState;
    });
  }

  @override
  // TODO: implement stateNotifier
  ValueNotifier<SilverCoinState> stateNotifier = ValueNotifier<SilverCoinState>(SilverCoinState.idle);

}