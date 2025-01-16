import 'package:endless_runner/auth/data/sound_effect_option.dart';

abstract class SoundEffectManager {
  Future<void> saveSoundEffectSettings(SoundEffectOption settings);  
}