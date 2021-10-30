import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Cm2pFirebaseUser {
  Cm2pFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

Cm2pFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Cm2pFirebaseUser> cm2pFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<Cm2pFirebaseUser>((user) => currentUser = Cm2pFirebaseUser(user));
