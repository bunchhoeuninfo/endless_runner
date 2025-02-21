import 'package:endless_runner/core/state/coin_state.dart';
import 'package:flutter/material.dart';

abstract class CoinStateManager {

  // -- Coin State Management --
  ValueNotifier<CoinState> get stateNotifier;
  void changeState(CoinState newState);

}