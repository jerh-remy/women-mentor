import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:women_mentor/models/user.dart';
import 'package:women_mentor/services/firestore_path.dart';
import 'package:women_mentor/services/firestore_service.dart';

class LoginViewModel with ChangeNotifier {
  LoginViewModel({required this.auth});
  final FirebaseAuth auth;

  bool isLoading = false;
  dynamic error;
  final _firestoreService = FirestoreService.instance;

  // Future<void> _signIn(Future<UserCredential> Function() signInMethod) async {
  //   try {
  //     isLoading = true;
  //     notifyListeners();
  //     await signInMethod();
  //     error = null;
  //   } catch (e) {
  //     error = e;
  //     rethrow;
  //   } finally {
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // Future<void> signInAnonymously() async {
  //   await _signIn(auth.signInAnonymously);
  // }

  Future createUser(AppUser user) async {
    try {
      await _firestoreService.setData(
          path: FirestorePath.user(user.id), data: user.toJson());
    } catch (e) {
      return e;
    }
  }

  Future createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String techLevel,
    String? age,
    String? ethnicity,
  }) async {
    try {
      final authResult = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await authResult.user?.sendEmailVerification();
      await createUser(
        AppUser(
          id: authResult.user!.uid,
          email: email,
          firstName: firstName,
          lastName: lastName,
          techLevel: techLevel,
          age: age,
          ethnicity: ethnicity,
        ),
      );
      // return authResult.user.uid;
      return authResult.user != null;
    } on FirebaseAuthException catch (e) {
      throw PlatformException(
        code: e.code,
        message: e.message,
      );
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();
      final authResult = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      error = null;
      print('email verified? : ${authResult.user?.emailVerified}');
      // if (authResult.user?.emailVerified != null) {
      //   if (authResult.user!.emailVerified) {
      //     // await populateCurrentUser(authResult.user);
      //     return true;
      //   } else {
      //     error = PlatformException(
      //       code: 'ERROR_SIGNING_IN',
      //       message:
      //           'You need to verify the email address you used to sign up for this account before logging in successfully.',
      //     );
      //   }
      // }
    } on FirebaseAuthException catch (e) {
      error = PlatformException(
        code: e.code,
        message: e.message,
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resetPassword({required String email}) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading = true;
      notifyListeners();

      final googleAccount = await GoogleSignIn().signIn();
      if (googleAccount != null) {
        final googleAuth = await googleAccount.authentication;
        if (googleAuth.accessToken != null && googleAuth.idToken != null) {
          await auth.signInWithCredential(
            GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken,
            ),
          );
          error = null;

          // User user = await userStream(uid: authResult.user.uid).first;
          // print('is user null? ${user == null}');
          // print(user?.firstName);
          // if (user == null) {
          //   _currentUser = User(
          //     id: authResult.user.uid,
          //     email: authResult.user.email,
          //     userRole: '',
          //     firstName: '',
          //     lastName: '',
          //   );
          //   return false;
          // }
          // await populateCurrentUser(authResult.user);

          // Once signed in, return the UserCredential
          // print('Auth current user ${auth.currentUser}');
          // return credential;
        } else {
          error = PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
            message: 'Missing Google Auth Token',
          );
        }
      } else {
        error = PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      }
      return null;
    } catch (e) {
      error = e;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      isLoading = true;
      notifyListeners();

      AccessToken accessToken = await FacebookAuth.instance.login();
      print(accessToken.toJson());

      error = null;
      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(accessToken.token);

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } on FacebookAuthException catch (e) {
      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          error = PlatformException(
            code: 'OPERATION_IN_PROGRESS',
            message: 'You have a previous login operation in progress',
          );
          break;

        case FacebookAuthErrorCode.CANCELLED:
          error = PlatformException(
            code: 'CANCELLED',
            message: 'login cancelled',
          );
          break;

        case FacebookAuthErrorCode.FAILED:
          error = PlatformException(
            code: 'FAILED',
            message: 'login failed',
          );
          break;
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
