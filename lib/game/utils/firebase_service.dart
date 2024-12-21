
import 'package:endless_runner/game/utils/firebase_options.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {

  Future<void> initialize() async {
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.firebaseOptions,
        );
        await FirebaseAuth.instance.signInAnonymously();
      }
    } catch (e, stackTrace) {
      LogUtil.error("Firebase Initialization failed: ", error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<void> fetchAppId() async {
    try {
      // Get the current user
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        LogUtil.info("No user is currently signed in.");
        return;
      }

      // Retrieve the ID token
      final idToken = await user.getIdToken();

      // Decode the ID token
      /*final decodedToken = JwtDecoder.decode(idToken!);

      // Access the app_id claim
      if (decodedToken.containsKey('app_id')) {
        final appId = decodedToken['app_id'];
        LogUtil.info("App ID: $appId");
      } else {
        LogUtil.info("app_id claim not found in the token.");
      }*/
    } catch (e) {
      LogUtil.error("Error retrieving app_id: $e");
    }
  }
}