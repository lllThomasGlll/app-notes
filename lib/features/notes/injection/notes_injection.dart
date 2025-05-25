import 'package:get_it/get_it.dart';

import 'package:app_notes/features/notes/domain/usecases/barrel_usecases.dart';
import 'package:app_notes/features/notes/presentation/bloc/barrel_notes_bloc.dart';
import 'package:app_notes/features/notes/domain/repositories/notes_repository.dart';
import 'package:app_notes/features/notes/data/repositories/notes_repository_impl.dart';
import 'package:app_notes/features/notes/data/datasources/notes_local_datasource.dart';

final sl = GetIt.instance;

Future<void> initNotes() async {
  // Data sources
  sl.registerLazySingleton<NotesLocalDatasource>(
    () => NotesLocalDatasourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<NotesRepository>(() => NotesRepositoryImpl(sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetNotes(sl()));
  sl.registerLazySingleton(() => AddNote(sl()));
  sl.registerLazySingleton(() => DeleteNote(sl()));
  sl.registerLazySingleton(() => UpdateNote(sl()));

  // Bloc
  sl.registerFactory(
    () => NotesBloc(
      getNotes: sl(),
      addNote: sl(),
      deleteNote: sl(),
      updateNote: sl(),
    ),
  );
}
