class SoundEffectOption {
  bool backgroundMusic;
  bool buttonClickSound;
  bool gameOverSound;

  SoundEffectOption({
    this.backgroundMusic = true,
    this.buttonClickSound = true,
    this.gameOverSound = true,
  });

  // Convert to a Map for easy storage (e.g., using SharedPreferences or Firebase)
  Map<String, bool> toMap() {
    return {
      'backgroundMusic': backgroundMusic,
      'buttonClickSound': buttonClickSound,
      'gameOverSound': gameOverSound,
    };
  }

  // Create a SoundSettings object from a Map
  factory SoundEffectOption.fromMap(Map<String, bool> map) {
    return SoundEffectOption(
      backgroundMusic: map['backgroundMusic'] ?? true,
      buttonClickSound: map['buttonClickSound'] ?? true,
      gameOverSound: map['gameOverSound'] ?? true,
    );
  }
}