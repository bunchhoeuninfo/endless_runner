import 'package:endless_runner/auth/data/sound_effect_option.dart';
import 'package:endless_runner/auth/managers/sound_effect_manager.dart';

class SoundEffectService implements SoundEffectManager {

  static const String backgroundMusicKey = 'backgroundMusic';
  static const String buttonClickSoundKey = 'buttonClickSound';
  static const String gameOverSoundKey = 'gameOverSound';

  @override
  Future<SoundEffectOption> loadSettings() {
    // TODO: implement loadSettings
    throw UnimplementedError();
  }

  @override
  Future<void> saveSettings(SoundEffectOption settings) {
    // TODO: implement saveSettings
    throw UnimplementedError();
  }

}