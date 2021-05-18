import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

/*
The authentication service contains functional features required for 
authentication such as sign in, sign up, sign out, etc.
It also includes authentication using external apps such as Google account
and Facebook account.

Note: Provider is used as the primary state management tool to provide
authentication service to the app.
*/

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebookLogin = FacebookLogin();

  AuthenticationService(this._firebaseAuth);

  // Notifies about changes to the user's sign-in state
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  // Returns the current User if they are currently signed-in, or null if not.
  User get currentUser => _firebaseAuth.currentUser;

  // Sign in a user with a given phone or email and password
  Future<bool> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

  // Signs out the current user who is signed is using phone and password
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    print("User signed out");
  }

  // Sign in a user using the Google account credentials
  // It will start an interactive sign in process
  Future<String> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn().catchError((onError) {
        print("Error $onError");
      });
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult = await _firebaseAuth
          .signInWithCredential(credential)
          .catchError((onError) {
        print("Error: $onError");
      });
      final User user = authResult.user;

      if (user != null) {
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final User currentUser = _firebaseAuth.currentUser;
        assert(user.uid == currentUser.uid);

        print('signInWithGoogle succeeded: $user');

        return '$user';
      }
      return null;
    } catch (e) {
      print(e);
      return "Sign In cancelled";
    }
  }

  // Signs out the current user who is signed in using the Google account
  // credentials
  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();

    print("Google User Signed Out");
  }

  // Sign in a user using the Facebook account credentials
  // It will start an interactive sign in process
  Future<String> signInWithFacebook() async {
    final FacebookLoginResult result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.cancelledByUser:
        print("Login Cancelled");
        break;
      case FacebookLoginStatus.error:
        print("Login Error!");
        break;
      case FacebookLoginStatus.loggedIn:
        try {
          final FacebookAccessToken accessToken = result.accessToken;
          AuthCredential credential =
              FacebookAuthProvider.credential(accessToken.token);
          final UserCredential authResult =
              await _firebaseAuth.signInWithCredential(credential);
          final User user = authResult.user;
          return '$user';
        } catch (e) {
          print(e);
        }
        break;
    }
    return null;
  }

  // Signs out the current user who is signed in using the Facebook account
  // credentials
  Future<void> signOutFacebook() async {
    await facebookLogin.logOut();

    print("Facebook User Signed Out");
  }

  // Signs out the current user
  Future<void> signOutFromAll() async {
    signOut();
    signOutGoogle();
    signOutFacebook();
  }

  // Sign up a user with a given phone or email and password
  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed Up";
    } catch (signUpError) {
      if (signUpError is PlatformException) {
        if (signUpError.code == 'ERROR_MAIL_ALREADY_IN_USE') {
          return "Email Already exists";
        }
      }
    }
    return "";
  }

  // Returns the current user email Id
  String returnCurrentEmailId() {
    return _firebaseAuth.currentUser.email;
  }
}
