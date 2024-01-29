import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedex_dima_new/domain/user.dart';

class AuthServices {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Create user object based on FirebaseUser
  UserAuthInfo _userFromFirebaseUser(User? user) {
    return UserAuthInfo(uid: user!.uid, email: user.email!, lastSignInTime: user.metadata.lastSignInTime.toString(), creationTime: user.metadata.creationTime.toString());
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
  Future registerWithEmailAndPassword(String email, String password) async {
    final UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

    final User? user = result.user;
    return _userFromFirebaseUser(user);
  }

  Future signInWithGoogle() async {
    // TODO
  }

  Future signInWithApple() async {
    // TODO
  }

  Future resetForgottenPassword(String email) async {
    // TODO
  }

  // Sign out
  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (error) {
      return null;
    }
  }


  final String usersCollectionName = 'users';

  Future<String?> getUsernameUsingEmail(String userEmail) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection(usersCollectionName)
          .where('email', isEqualTo: userEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String username = querySnapshot.docs[0].get('username');
        return username;
      } else {
        return null;
      }
    } catch (e) {
      print('Error retrieving username: $e');
      return null;
    }
  }

  Future<String?> getEmailUsingUsername(String username) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection(usersCollectionName)
          .where('username', isEqualTo: username)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String username = querySnapshot.docs[0].get('email');
        return username;
      } else {
        return null;
      }
    } catch (e) {
      print('Error retrieving email: $e');
      return null;
    }
  }

  Future<void> addNewUserWithEmailAndUsername(String email, String username) async {
    try {
      CollectionReference usersCollection = FirebaseFirestore.instance.collection(usersCollectionName);
      QuerySnapshot<Object?> existingUser = await usersCollection
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (existingUser.docs.isEmpty) {
        await usersCollection.add({
          'email': email,
          'username': username,
        });
      } else {
        return;
      }
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  Future signInWithUsernameAndPassword(String username, String password) async {
    String? email = await getEmailUsingUsername(username);
    final UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email!, password: password);
    final User? user = result.user;
    return _userFromFirebaseUser(user);
  }

  Future registerWithEmailUsernameAndPassword(String email, String username, String password) async {
    final UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    await addNewUserWithEmailAndUsername(email, username);

    final User? user = result.user;
    return _userFromFirebaseUser(user);
  }




  String extractFirebaseErrorMessage(String errorMessage) {
    int closingBracketIndex = errorMessage.indexOf(']');
    if (closingBracketIndex != -1 && closingBracketIndex + 1 < errorMessage.length) {
      return errorMessage.substring(closingBracketIndex + 1).trim();
    } else { return errorMessage; }
  }
}