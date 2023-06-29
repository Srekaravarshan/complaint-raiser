import 'package:complaint_raiser_official/models/user_model.dart';
import 'package:complaint_raiser_official/routes.dart';
import 'package:complaint_raiser_official/ui/auth/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  unauthenticated,
  registering
}
/*
The UI will depends on the Status to decide which screen/action to be done.

- Uninitialized - Checking user is logged or not, the Splash Screen will be shown
- Authenticated - User is authenticated successfully, Home Page will be shown
- Authenticating - Sign In button just been pressed, progress bar will be shown
- Unauthenticated - User is not authenticated, login page will be shown
- Registering - User just pressed registering, progress bar will be shown

Take note, this is just an idea. You can remove or further add more different
status for your UI or widgets to listen.
 */

class AuthProvider extends ChangeNotifier {
  //Firebase Auth object
  late FirebaseAuth _auth;

  //Default status
  Status _status = Status.uninitialized;

  Status get status => _status;

  Stream<UserModel> get user => _auth.authStateChanges().map(_userFromFirebase);
  User? get currentUser => _auth.currentUser;

  AuthProvider() {
    //initialise object
    _auth = FirebaseAuth.instance;

    //listener for authentication changes such as user sign in and sign out
    _auth.authStateChanges().listen(onAuthStateChanged);
  }

  //Create user object based on the given User
  UserModel _userFromFirebase(User? user) {
    if (user == null) {
      return UserModel(displayName: 'Null', uid: 'null');
    }

    return UserModel(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        phoneNumber: user.phoneNumber,
        photoUrl: user.photoURL);
  }

  //Method to detect live auth changes such as user sign in and sign out
  Future<void> onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.unauthenticated;
    } else {
      _userFromFirebase(firebaseUser);
      _status = Status.authenticated;
    }
    notifyListeners();
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      print('signinwith phone-------=-=-========================');
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _auth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          print('code sent------------------------------------------');
          Navigator.pushNamed(context, Routes.otp,
              arguments: OtpArguments(verificationId));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {}
  }

  Future<bool> verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _status = Status.authenticating;
    notifyListeners();

    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);

      User? user = (await _auth.signInWithCredential(creds)).user;

      // _userFromFirebase(user);
      if (user != null) {
        onSuccess();
      }
      // _isLoading = false;
      // notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      // showSnackBar(context, e.message.toString());
      // _isLoading = false;
      // notifyListeners();
      return false;
    }
  }

  //Method for new user registration using email and password
  Future<UserModel> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      _status = Status.registering;
      notifyListeners();
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return _userFromFirebase(result.user);
    } catch (e) {
      print("Error on the new user registration = " + e.toString());
      _status = Status.unauthenticated;
      notifyListeners();
      return UserModel(displayName: 'Null', uid: 'null');
    }
  }

  //Method to handle user sign in using email and password
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      _status = Status.authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print("Error on the sign in = " + e.toString());
      _status = Status.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  //Method to handle password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  //Method to handle user signing out
  Future signOut() async {
    _auth.signOut();
    _status = Status.unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}
