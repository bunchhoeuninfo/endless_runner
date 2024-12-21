

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:endless_runner/game/utils/firebase_service.dart';
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

    final connectResult = await Connectivity().checkConnectivity();
    if (connectResult[0] == ConnectivityResult.none) {
      LogUtil.error("No internet connection available.");
      appWidget = MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NoInternetWidget(
          onRetry: () {
            main(); // Retry by restarting the main method
          },
        ),
      );
    } else {
      final firebaseService = FirebaseService();
      await firebaseService.initialize();
      //await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);
      //await FirebaseAppCheck.instance.activate();
      LogUtil.debug('Logging here');
      setDeviceOrientation();
      appWidget = const GameMain();
      LogUtil.info("Succesfully initialized game app...");
    }
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

