import 'package:flutter_secure_storage/flutter_secure_storage.dart';


const secureStorage = FlutterSecureStorage();

Future<void> storeUserId(String userId) async {
  await secureStorage.write(key: 'userId', value: userId);
}

Future<String?> getUserId() async {
  final userId = await secureStorage.read(key: 'userId');
  return userId;
}
