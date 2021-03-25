import 'package:firebase_auth/firebase_auth.dart';
import 'package:women_mentor/services/firestore_database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider<User?>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges());

final authCurrentUserProvider =
    Provider<User?>((ref) => ref.watch(firebaseAuthProvider).currentUser);

final databaseProvider = Provider<FirestoreDatabase>((ref) {
  final auth = ref.watch(authStateChangesProvider);

  if (auth.data?.value?.uid != null) {
    return FirestoreDatabase(uid: auth.data!.value!.uid);
  }
  throw UnimplementedError();
});

final loggerProvider = Provider<Logger>((ref) => Logger(
      printer: PrettyPrinter(
        methodCount: 1,
        printEmojis: false,
      ),
    ));
