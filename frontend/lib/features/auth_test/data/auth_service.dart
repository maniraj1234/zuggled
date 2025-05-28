import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? _verificationId; // Stores the verification ID received from Firebase
  String? _phoneNumberBeingVerified; // Stores the phone number being verified
  Stream<User?> get user => _firebaseAuth.authStateChanges();
  String? get verificationId => _verificationId;
  String? get phoneNumberBeingVerified => _phoneNumberBeingVerified;
  User? get currentUser => _firebaseAuth.currentUser;

  Future<bool> isLoggedIn() async {
    final user = _firebaseAuth.currentUser;
    return user != null;
  }

  Future<bool> sendOtp(String phoneNumber) async {
    _phoneNumberBeingVerified = phoneNumber;
    try {
      await _firebaseAuth.verifyPhoneNumber(
        
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          print('AuthService: Auto-verification completed.');
        },
        verificationFailed: (FirebaseAuthException e) {
          print('AuthService Error: ${e.code} - ${e.message}');
          throw Exception('OTP sending failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          print('OTP sent to $phoneNumber. ID: $verificationId');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
          print('Auto-retrieval timed out. ID: $verificationId');
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
