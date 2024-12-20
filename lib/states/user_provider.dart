import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final userAutnenticationProvider =
    StateNotifierProvider<UserAutnenticationNotifier, User?>((ref) {
  final user = ref.watch(userProvider);
  return UserAutnenticationNotifier(user.value);
});

class UserAutnenticationNotifier extends StateNotifier<User?> {
  final User? user;
  UserAutnenticationNotifier(this.user) : super(user);

  Future<void> signInAnonymously() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  Future<void> signOutAnonymously() async {
    await FirebaseAuth.instance.signOut();
  }
}
