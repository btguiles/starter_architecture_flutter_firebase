import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_auth_repository.g.dart';

// Defines the AuthRepository class
// A repository class defines how we can interact with a data source (often supports CRUD operations)
// Data sources can include databases, web services, device-specific/OS APIs, or memory
class AuthRepository {
  AuthRepository(this._auth);
  final FirebaseAuth _auth;

  Stream<User?> authStateChanges() => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<void> signInAnonymously() {
    return _auth.signInAnonymously();
  }
}

// Creates the provider 'firebaseAuthProvider'
// This provider holds the FirebaseAuth.instance state that is fed to the AuthRepository instance
// Examples of how you might use this provider:
// onPressed: () => ref.read(firebaseAuthProvider).signInAnonymously();
// final user = ref.watch(firebaseAuthProvider).currentUser;
@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(FirebaseAuthRef ref) {
  return FirebaseAuth.instance;
}

// Creates the provider 'authRepositoryProvider'
// This provider's state can be accessed or modified via the methods specified in the repository class
// Examples of how you might use this provider:
// final currentUser = ref.watch(authRepositoryProvider).currentUser;
// This provider lets you access the AuthRepository, whose purpose is to abstract the Firebase Auth API
@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(ref.watch(firebaseAuthProvider));
}

// Creates the provider authStateChangesProvider for the Stream<User?> instance
// I don't know what this one does. ¯\_(ツ)_/¯
// Also, I can't find any instances of authStateChangesProvider in the codebase aside from firebase_auth_repository.g.dart
@riverpod
Stream<User?> authStateChanges(AuthStateChangesRef ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
}
