

import 'package:endless_runner/game/endless_runner_game.dart';

abstract class GameServiceManager {

  void setupBackground(EndlessRunnerGame game);
  void gameOver(EndlessRunnerGame game);
  void restartGame(EndlessRunnerGame game);
  void startGame(EndlessRunnerGame game);
  void pauseGame(EndlessRunnerGame game);
  void addEntities(EndlessRunnerGame game);
  void resumeGame(EndlessRunnerGame game);  
  
}