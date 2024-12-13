
import 'dart:math';

import 'package:endless_runner/components/player.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

class EndlessRunnerGame extends FlameGame with HasCollisionDetection, TapDetector {
  late Player _player;
  late TimerComponent _obstacleTimer;
  late Random _random = Random();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    //Load player
    _player = Player();
    add(_player);
  }

}