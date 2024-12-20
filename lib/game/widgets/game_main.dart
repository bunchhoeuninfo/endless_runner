

import 'package:endless_runner/game/widgets/screen_widget.dart';
import 'package:flutter/material.dart';

class GameMain extends StatelessWidget {
  const GameMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //title: 'Material App',
      home: ScreenWidget(),
    );
  }
}