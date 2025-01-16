import 'package:endless_runner/auth/data/sound_effect_option.dart';

abstract class SoundEffectManager {
  Future<void> saveSettings(SoundEffectOption settings);
  Future<SoundEffectOption> loadSettings();
}