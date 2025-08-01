import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/services/navigation/main_router.dart';
import 'package:frontend/services/navigation/navigation_service.dart';

class AuthService {
  /// This will give an instance of AuthService
  /// So we don't need to create a new one everytime
  AuthService._();

  /// Private singleton instance
  static AuthService? _instance;

  /// Get instance
  factory AuthService() {
    _instance = AuthService._();
    return _instance!;
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? _verificationId; // Stores the verification ID received from Firebase
  String? _phoneNumberBeingVerified; // Stores the phone number being verified
  Stream<User?> get user => _firebaseAuth.authStateChanges();
  String? get verificationId => _verificationId;
  String? get phoneNumberBeingVerified => _phoneNumberBeingVerified;
  User? get currentUser => _firebaseAuth.currentUser;

  Future<String?> getUserToken() async {
    return await _firebaseAuth.currentUser?.getIdToken();
  }

  Future<bool> isLoggedIn() async {
    final user = _firebaseAuth.currentUser;
    return user != null;
  }

  Future<bool> isRegistered()async{ 
    final idTokenResult=await _firebaseAuth.currentUser?.getIdTokenResult(true); //force refresh the token 
    final _claims=idTokenResult?.claims; //get user claims with idToken

  if (_claims != null && _claims.containsKey('role')) {
    return true; // 'creator' or 'customer'
  } else {
    return false;
  }

  }
  Future<String> getUserRole()async{
    if(!await isLoggedIn()){
      //navigating to login view for users who are not logged in
      NavigationService(mainRouter).go('/login');
    }
    final idTokenResult=await _firebaseAuth.currentUser?.getIdTokenResult(true);
    final _claims=idTokenResult?.claims;
    return _claims?['role'];
  }

  Future<bool> sendOtp(String phoneNumber) async {
    _phoneNumberBeingVerified = phoneNumber;
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          if (kDebugMode) {
            print('AuthService: Auto-verification completed.');
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          if (kDebugMode) {
            print('AuthService Error: ${e.code} - ${e.message}');
          }
          throw Exception('OTP sending failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          if (kDebugMode) {
            print('OTP sent to $phoneNumber. ID: $verificationId');
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
          if (kDebugMode) {
            print('Auto-retrieval timed out. ID: $verificationId');
          }
        },
        timeout: const Duration(seconds: 60),
      );
      return true;
    } on FirebaseAuthException catch (e) {
      throw Exception('Firebase Error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<UserCredential> verifyOtp(String otp) async {
    if (_verificationId == null) {
      throw Exception('No verification ID available. Please send OTP again.');
    }
    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: otp,
    );

    return await _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
