import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:app_notes/core/database/database_helper.dart';

final sl = GetIt.instance;

Future<void> initCore() async {
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);
  sl.registerLazySingleton(() => const FlutterSecureStorage());
}
