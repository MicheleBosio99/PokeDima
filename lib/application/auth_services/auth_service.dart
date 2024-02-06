import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';
import 'package:pokedex_dima_new/domain/user.dart';

class AuthServices {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseCloudServices _firebaseCloudServices = FirebaseCloudServices();

  UserAuthInfo _userFromFirebaseUser(User? user) {
    return UserAuthInfo(
        uid: user!.uid,
        email: user.email!,
        lastSignInTime: user.metadata.lastSignInTime.toString(),
        creationTime: user.metadata.creationTime.toString()
    );
  }

  Stream<UserAuthInfo>? get user {
    return _firebaseAuth.authStateChanges().map((user) => _userFromFirebaseUser(user));
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    final UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    final User? user = result.user;
    return _userFromFirebaseUser(user);
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    final UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

    final User? user = result.user;
    return _userFromFirebaseUser(user);
  }

  Future signInWithGoogle() async {
    // TODO
  }

  Future resetForgottenPassword(String email) async {
    // TODO
  }

  Future signOut() async {
    try { return await _firebaseAuth.signOut(); }
    catch (error) { return null; }
  }


  Future signInWithUsernameAndPassword(String username, String password) async {
    String? email = await _firebaseCloudServices.getEmailUsingUsername(username);
    if (email == null) { throw Exception("No user with this username found."); }

    final UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    final User? user = result.user;
    return _userFromFirebaseUser(user);
  }

  Future registerWithEmailUsernameAndPassword(String email, String username, String password) async {
    final UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    await _firebaseCloudServices.addNewUserWithEmailAndUsername(email, username);

    final User? user = result.user;
    return _userFromFirebaseUser(user);
  }




  // HELPER METHODS

  String extractFirebaseErrorMessage(String errorMessage) {
    int closingBracketIndex = errorMessage.indexOf(']');
    if (closingBracketIndex != -1 && closingBracketIndex + 1 < errorMessage.length) {
      return errorMessage.substring(closingBracketIndex + 1).trim();
    } else { return errorMessage; }
  }
}