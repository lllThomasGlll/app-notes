import 'package:app_notes/core/injection/core_injection.dart' as core_inj;
import 'package:app_notes/features/auth/injection/auth_injection.dart'
    as auth_inj;
import 'package:app_notes/features/register/injection/register_injection.dart'
    as register_inj;
import 'package:app_notes/features/notes/injection/notes_injection.dart'
    as notes_sl;

export 'package:app_notes/core/injection/core_injection.dart';

Future<void> init() async {
  await core_inj.initCore();
  await auth_inj.initAuth();
  await register_inj.initRegister();
  await notes_sl.initNotes();
}
