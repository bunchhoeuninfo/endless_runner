

import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class StartButton extends ButtonComponent with HasGameRef<EndlessRunnerGame> {

  final VoidCallback onPressedCallback;

  StartButton(this.onPressedCallback)
      : super(
          button: TextComponent(
            text: 'Play',
            textRenderer: TextPaint(
              style: TextStyle(
                fontSize: 32,
                color: Colors.amber,
              ),
            ),
          ),
          onPressed: onPressedCallback,
        );

  @override
  Future<void> onLoad() async {
    position = Vector2(gameRef.size.x / 2 - 50, gameRef.size.y / 2 - 20);
    size = Vector2(100, 40);
    super.onLoad();
  }

}