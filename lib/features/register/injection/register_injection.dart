import 'package:get_it/get_it.dart';

import 'package:app_notes/features/register/domain/usecases/register_user.dart';
import 'package:app_notes/features/register/presentation/bloc/register_bloc.dart';
import 'package:app_notes/features/register/domain/repositories/register_repository.dart';
import 'package:app_notes/features/register/data/repositories/register_repository_impl.dart';
import 'package:app_notes/features/register/data/datasources/register_local_datasource.dart';

final sl = GetIt.instance;

Future<void> initRegister() async {
  // Data sources
  sl.registerLazySingleton<RegisterLocalDatasource>(
    () => RegisterLocalDatasourceImpl(sl()),
  );

  // Repositorios
  sl.registerLazySingleton<RegisterRepository>(
    () => RegisterRepositoryImpl(sl()),
  );

  // Use Cases
  sl.registerLazySingleton<RegisterUserUseCase>(
    () => RegisterUserUseCase(sl()),
  );

  // Bloc
  sl.registerFactory(() => RegisterBloc(sl()));
}
