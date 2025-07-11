import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<UserCredential> signInAnonymously() async {
    try {
      return await _auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<void> updateDisplayName(String displayName) async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.updateDisplayName(displayName);
    }
  }

  Future<void> updateEmail(String email) async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        await user.updateEmail(email);
      } on FirebaseAuthException catch (e) {
        throw _handleAuthException(e);
      }
    }
  }

  Future<void> updatePassword(String password) async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        await user.updatePassword(password);
      } on FirebaseAuthException catch (e) {
        throw _handleAuthException(e);
      }
    }
  }

  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        await user.delete();
      } on FirebaseAuthException catch (e) {
        throw _handleAuthException(e);
      }
    }
  }

  Future<void> reauthenticateWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final user = _auth.currentUser;
    if (user != null) {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      try {
        await user.reauthenticateWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        throw _handleAuthException(e);
      }
    }
  }

  Future<bool> checkEmailExists(String email) async {
    try {
      final methods = await _auth.fetchSignInMethodsForEmail(email);
      return methods.isNotEmpty;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  AuthException _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return AuthException(
          'No user found with this email address.',
          AuthExceptionType.userNotFound,
        );
      case 'wrong-password':
        return AuthException(
          'Wrong password provided.',
          AuthExceptionType.wrongPassword,
        );
      case 'weak-password':
        return AuthException(
          'The password provided is too weak.',
          AuthExceptionType.weakPassword,
        );
      case 'email-already-in-use':
        return AuthException(
          'An account already exists with this email.',
          AuthExceptionType.emailAlreadyInUse,
        );
      case 'invalid-email':
        return AuthException(
          'Invalid email address.',
          AuthExceptionType.invalidEmail,
        );
      case 'user-disabled':
        return AuthException(
          'This user account has been disabled.',
          AuthExceptionType.userDisabled,
        );
      case 'too-many-requests':
        return AuthException(
          'Too many requests. Please try again later.',
          AuthExceptionType.tooManyRequests,
        );
      case 'operation-not-allowed':
        return AuthException(
          'This operation is not allowed.',
          AuthExceptionType.operationNotAllowed,
        );
      case 'requires-recent-login':
        return AuthException(
          'This operation is sensitive and requires recent authentication.',
          AuthExceptionType.requiresRecentLogin,
        );
      default:
        return AuthException(
          e.message ?? 'An unknown error occurred.',
          AuthExceptionType.unknown,
        );
    }
  }
}

class AuthException implements Exception {
  final String message;
  final AuthExceptionType type;

  const AuthException(this.message, this.type);

  @override
  String toString() => message;
}

enum AuthExceptionType {
  userNotFound,
  wrongPassword,
  weakPassword,
  emailAlreadyInUse,
  invalidEmail,
  userDisabled,
  tooManyRequests,
  operationNotAllowed,
  requiresRecentLogin,
  unknown,
}