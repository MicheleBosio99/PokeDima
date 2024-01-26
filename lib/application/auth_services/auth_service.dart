import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedex_dima_new/domain/user.dart';

class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Create user object based on FirebaseUser
  UserAuthInfo _userFromFirebaseUser(User? user) {
    return UserAuthInfo(uid: user!.uid);
  }

  // Detect auth changes and notify provider
  Stream<UserAuthInfo>? get user {
    return _firebaseAuth.authStateChanges().map((user) => _userFromFirebaseUser(user));
  }


  // Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    final UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    final User? user = result.user;
    return _userFromFirebaseUser(user);
  }

  // Register with email and password
  Future registerWithEmailAndPassword(String email, String user, String password) async {
    final UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

    // TODO: Save User with username in cloud firestore

    final User? user = result.user;
    return _userFromFirebaseUser(user);
  }

  // Sign out
  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (error) {
      return null;
    }
  }
}