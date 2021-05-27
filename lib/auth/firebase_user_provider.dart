import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Fluttermet05FirebaseUser {
  Fluttermet05FirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

Fluttermet05FirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Fluttermet05FirebaseUser> fluttermet05FirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<Fluttermet05FirebaseUser>(
            (user) => currentUser = Fluttermet05FirebaseUser(user));
