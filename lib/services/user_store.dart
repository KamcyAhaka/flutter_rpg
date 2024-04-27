import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_rpg/services/firebase_auth_services.dart'; // for ChangeNotifier

class UserStore extends ChangeNotifier {
  final AuthService _authService = AuthService(); // Create an AuthService instance
  User? _currentUser; // Store the currently logged in user

  User? get currentUser => _currentUser; // Getter for currentUser

  // A method to handle user registration using AuthService signup function
  Future<void> signup(String email, String password) async {
    try {
      final userCredential = await _authService.signup(email, password);
			if (userCredential != null) {
      	_currentUser = userCredential.user; // Update currentUser
			}
      notifyListeners(); // Notify listeners of the change
    } on Exception catch (e) {
      // Handle signup exceptions (e.g., print error message, show a snackbar)
      print("Error during signup: $e");
    }
  }

  // A method to handle user signin using AuthService signin function
  Future<void> signin(String email, String password) async {
    try {
      final userCredential = await _authService.signin(email, password);
			if (userCredential != null) {
      	_currentUser = userCredential.user; // Update currentUser
			}
      notifyListeners(); // Notify listeners of the change
    } on Exception catch (e) {
      // Handle signin exceptions (e.g., print error message, show a snackbar)
      print("Error during signin: $e");
    }
  }

  // A method to handle user signout using AuthService signOut function
  Future<void> signOut() async {
    await _authService.signOut();
    _currentUser = null; // Clear currentUser
    notifyListeners(); // Notify listeners of the change
  }

  // Add other methods for various auth actions as needed
  // ... (e.g., methods for checking login status, sending password reset emails)

  // You can also listen to the authStateChanges stream of AuthService
  // to automatically update currentUser whenever it changes.
	void startListeningToAuthChanges() {
		_authService.authStateChanges.listen((user) {
			_currentUser = user;
			notifyListeners();
		});
	}


  @override
  void dispose() {
    // Clean up any resources when the store is disposed
    super.dispose();
  }
}
