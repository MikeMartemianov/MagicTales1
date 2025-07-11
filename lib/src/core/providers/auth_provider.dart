import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_profile.dart';
import '../services/storage_service.dart';
import '../services/auth_service.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  @override
  AuthState build() {
    // Listen to Firebase Auth state changes
    ref.listen(authStateProvider, (previous, next) {
      _updateAuthState(next);
    });
    
    _loadCurrentUser();
    return const AuthState();
  }

  Future<void> _loadCurrentUser() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userProfile = await StorageService.getUserProfile(currentUser.uid);
        if (userProfile != null) {
          state = AuthState(
            isAuthenticated: true,
            user: currentUser,
            userProfile: userProfile,
            isLoading: false,
          );
        } else {
          // User exists in Firebase but no profile, might need to complete setup
          state = AuthState(
            isAuthenticated: true,
            user: currentUser,
            userProfile: null,
            isLoading: false,
            needsProfileSetup: true,
          );
        }
      } else {
        state = const AuthState(isAuthenticated: false, isLoading: false);
      }
    } catch (e) {
      state = AuthState(
        isAuthenticated: false,
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> _updateAuthState(User? user) async {
    if (user != null) {
      final userProfile = await StorageService.getUserProfile(user.uid);
      state = AuthState(
        isAuthenticated: true,
        user: user,
        userProfile: userProfile,
        isLoading: false,
        needsProfileSetup: userProfile == null,
      );
      
      if (userProfile != null) {
        await StorageService.setCurrentUserId(user.uid);
      }
    } else {
      state = const AuthState(isAuthenticated: false, isLoading: false);
      await StorageService.clearCurrentUser();
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final authService = ref.read(authServiceProvider);
      await authService.signInWithEmailAndPassword(email, password);
      // State will be updated by the auth state listener
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final authService = ref.read(authServiceProvider);
      await authService.signUpWithEmailAndPassword(email, password);
      // State will be updated by the auth state listener
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> signInAnonymously() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final authService = ref.read(authServiceProvider);
      await authService.signInAnonymously();
      // State will be updated by the auth state listener
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final authService = ref.read(authServiceProvider);
      await authService.signOut();
      // State will be updated by the auth state listener
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> completeProfileSetup(UserProfile profile) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await StorageService.saveUserProfile(profile);
      await StorageService.setCurrentUserId(profile.id);
      
      state = state.copyWith(
        userProfile: profile,
        needsProfileSetup: false,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> updateUserProfile(UserProfile profile) async {
    try {
      await StorageService.saveUserProfile(profile);
      state = state.copyWith(userProfile: profile);
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

@riverpod
Stream<User?> authState(AuthStateRef ref) {
  return FirebaseAuth.instance.authStateChanges();
}

class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final User? user;
  final UserProfile? userProfile;
  final String? error;
  final bool needsProfileSetup;

  const AuthState({
    this.isAuthenticated = false,
    this.isLoading = true,
    this.user,
    this.userProfile,
    this.error,
    this.needsProfileSetup = false,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    User? user,
    UserProfile? userProfile,
    String? error,
    bool? needsProfileSetup,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      userProfile: userProfile ?? this.userProfile,
      error: error,
      needsProfileSetup: needsProfileSetup ?? this.needsProfileSetup,
    );
  }

  bool get isGuest => isAuthenticated && user?.isAnonymous == true;
  bool get isSignedIn => isAuthenticated && user?.isAnonymous == false;
  bool get hasCompleteProfile => userProfile != null && !needsProfileSetup;
}