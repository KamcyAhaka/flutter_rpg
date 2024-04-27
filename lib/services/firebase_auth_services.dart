import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final  FirebaseAuth _auth = FirebaseAuth.instance;

	static get auth => _auth;

  // Stream to listen to authentication state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Function to handle user registration
  Future<UserCredential?> signup(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('Password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      } else {
        throw Exception(e.message);
      }
    } catch (e) {
      throw Exception(e.toString()); // Handle other exceptions generically
    }
  }

  // Function to handle user signin
  Future<UserCredential?> signin(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that email.');
      } else {
        throw Exception(e.message);
      }
    } catch (e) {
      throw Exception(e.toString()); // Handle other exceptions generically
    }
  }

  // Function to handle user signout
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
