import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FcmUtils {
  final FirebaseMessaging _messaging = FirebaseMessaging();

  final _secure = FlutterSecureStorage();

  Future<void> getTokenFirebase() async {
    try {
      final itemToken = await _messaging.getToken();
      if (itemToken == null) return;

      final readTokenFcm = await _secure.read(key: 'token_fcm');
      print(itemToken);
      if (readTokenFcm == null) {
        await _secure.write(key: 'token_fcm', value: itemToken);
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      return;
    }
  }
}
