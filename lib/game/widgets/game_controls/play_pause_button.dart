
import 'package:endless_runner/game/endless_runner_game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';


class PlayPauseButton extends ButtonComponent with HasGameRef<EndlessRunnerGame> {
  late SpriteComponent playIcon;
  late SpriteComponent pauseIcon;
  bool isPaused = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Load play and pause icons as sprites using gameRef.images
    //final playSprite = await gameRef.loadSprite('red.png');
    final playSprite =  Sprite(gameRef.images.fromCache('red.png'));
    final pauseSprite = Sprite(gameRef.images.fromCache('blue.png'));

    // Create SpriteComponents for both play and pause icons
    playIcon = SpriteComponent(sprite: playSprite, size: Vector2(50, 50));
    pauseIcon = SpriteComponent(sprite: pauseSprite, size: Vector2(50, 50));

    // Initially show the play icon
    add(playIcon);

    // Define onPressed behavior
    onPressed = () {
      // Toggle game state
      isPaused = !isPaused;

      // Switch between the play and pause icons
      if (isPaused) {
        remove(playIcon);
        add(pauseIcon);
      } else {
        remove(pauseIcon);
        add(playIcon);
      }

      // Update game state as needed (like pausing or resuming)
      if (isPaused) {
        gameRef.pauseEngine();  // Assuming the game has this method
      } else {
        gameRef.resumeEngine();
      }
    };
  }
}

