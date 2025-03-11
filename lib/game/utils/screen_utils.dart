import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class ScreenUtils {
  static Vector2 getScreenSize() {
    final Size screenSize = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    
    return Vector2(screenSize.width, screenSize.height);
  }
}