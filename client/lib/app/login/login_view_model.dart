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
  final _firestoreService = FirestoreService.instance;

  Future _createUser(AppUser user) async {
    try {
      await _firestoreService.setData(
          path: FirestorePath.user(user.id), data: user.toJson());
    } catch (e) {
      return e;
    }
  }

  Future createUserDocumentAfterSocialSignIn({
    required String userId,
    required String firstName,
    required String lastName,
    required String techLevel,
    int? age,
    String? ethnicity,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      await _createUser(
        AppUser(
          id: userId,
          firstName: firstName,
          lastName: lastName,
          techLevel: techLevel,
          age: age,
          ethnicity: ethnicity,
        ),
      );
    } catch (e) {
      throw e;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String techLevel,
    int? age,
    String? ethnicity,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      final authResult = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await authResult.user?.sendEmailVerification();
      await _createUser(
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

      return authResult.user != null;
    } on FirebaseAuthException catch (e) {
      throw PlatformException(
        code: e.code,
        message: e.message,
      );
    } finally {
      isLoading = false;
      notifyListeners();
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
      return authResult.user != null;
    } on FirebaseAuthException catch (e) {
      throw PlatformException(
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
          final authResult = await auth.signInWithCredential(
            GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken,
            ),
          );

          final user = authResult.user;

          // await _createUser(
          //   AppUser(
          //     id: user!.uid,
          //     firstName: user.displayName?.split(' ')[0] ?? '',
          //     lastName: user.displayName?.split(' ').last ?? '',
          //     techLevel: techLevel,
          //     age: age,
          //     ethnicity: ethnicity,
          //   ),
          // );

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
          throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
            message: 'Missing Google Auth Token',
          );
        }
      } else {
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      }
      return null;
    } catch (e) {
      throw e;
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

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(accessToken.token);

      // Once signed in, return the UserCredential
      await auth.signInWithCredential(facebookAuthCredential);
    } on FacebookAuthException catch (e) {
      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          throw PlatformException(
            code: 'OPERATION_IN_PROGRESS',
            message: 'You have a previous login operation in progress',
          );

        case FacebookAuthErrorCode.CANCELLED:
          throw PlatformException(
            code: 'CANCELLED',
            message: 'login cancelled',
          );

        case FacebookAuthErrorCode.FAILED:
          throw PlatformException(
            code: 'FAILED',
            message: 'login failed',
          );
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
