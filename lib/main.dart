import 'package:endless_runner/game/utils/log_util.dart';
import 'package:endless_runner/game/widgets/commons/game_main.dart';
import 'package:endless_runner/game/widgets/commons/no_internet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Widget appWidget;
  
  try {
    LogUtil.debug('Try to initialize main app');
    
    LogUtil.debug('Logging here');
    setDeviceOrientation();
    appWidget = const GameMain();
    LogUtil.info("Succesfully initialized game app...");
    
  } catch (e) {
    appWidget = MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NoInternetWidget(
        onRetry: () {
          main(); // Retry on error
        },
      ),
    );

    LogUtil.error('Exception -> $e');
  }

  runApp(appWidget);

}

void setDeviceOrientation() {
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]
  );
}

