import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider, AuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

// EmailAuthProvider and AuthProvider are hidden from the import above
// This is because we are defining our own EmailAuthProvider and AuthProvider
// This provides a list of AuthProviders that can be displayed using the firebase_ui_auth package
@Riverpod(keepAlive: true)
List<AuthProvider<AuthListener, AuthCredential>> authProviders(AuthProvidersRef ref) {
  return [
    EmailAuthProvider(),
  ];
}
