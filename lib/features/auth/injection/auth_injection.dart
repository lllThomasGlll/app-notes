import 'package:get_it/get_it.dart';

import 'package:app_notes/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_notes/features/auth/domain/usecases/barrel_usecases.dart';
import 'package:app_notes/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_notes/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:app_notes/features/auth/data/datasources/auth_local_datasource.dart';

final sl = GetIt.instance;

Future<void> initAuth() async {
  // Data sources
  sl.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(sl()),
  );

  // Repositorios
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => LogoutUser(sl()));
  sl.registerLazySingleton(() => CheckSession(sl()));

  // Bloc
  sl.registerFactory(
    () => AuthBloc(loginUser: sl(), logoutUser: sl(), checkSession: sl()),
  );
}
