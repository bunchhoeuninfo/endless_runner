import 'package:endless_runner/endless_runner_game.dart';
import 'package:flame/components.dart';

class CoinScore extends TextComponent with HasGameRef<EndlessRunnerGame> {
  CoinScore() 
  : super(
    text: 'Score: 0',
    position: Vector2(10, 10),
    anchor: Anchor.topLeft,
    priority: 10,
  );

  @override
  void update(double dt) {
    super.update(dt);
    text = 'Score: ${gameRef.coinScore}';
  }
}