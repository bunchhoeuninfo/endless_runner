import 'package:endless_runner/endless_runner_game.dart';
import 'package:flame/components.dart';

class CoinCounter extends TextComponent with HasGameRef<EndlessRunnerGame> {

  CoinCounter() 
    : super(
      text: 'Coins: 0',
      position: Vector2(10, 40),
      anchor: Anchor.topLeft,
      priority: 10,  //Ensure it is on top of the components
    );

  @override
  void update(double dt) {
    super.update(dt);
    text = 'Coins: ${gameRef.coinCollected}';   // Update text with current coin count
  }

}