import 'package:flutter_full_auth/data/repos/user/user_repo.dart';
import 'package:flutter_full_auth/features/authentication/screens/login/login.dart';
import 'package:flutter_full_auth/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:flutter_full_auth/features/authentication/screens/signup/verify_email.dart';
import 'package:flutter_full_auth/nav_menu.dart';
import 'package:flutter_full_auth/utils/exceptions/exceptions.dart';
import 'package:flutter_full_auth/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:flutter_full_auth/utils/exceptions/firebase_exceptions.dart';
import 'package:flutter_full_auth/utils/exceptions/format_exceptions.dart';
import 'package:flutter_full_auth/utils/exceptions/platform_exceptions.dart';
import 'package:flutter_full_auth/utils/local_storage/storage_utility.dart';
import 'package:flutter_full_auth/utils/popups/snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo extends GetxController {
  static AuthRepo get instance => Get.find();

  // -- variables --
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // -- get authenticated user data --
  User? get authUser => _auth.currentUser;

  // -- called from main.dart on app launch --
  @override
  void onReady() {
    // remove the native splash screen
    FlutterNativeSplash.remove();

    // redirect to the relevant screen
    screenRedirect();
  }

  // -- function to load the relevant screen
  void screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      if (user.emailVerified) {
        // initialize user-specific local storage
        await CLocalStorage.init(user.uid);

        Get.offAll(() => const NavMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(
              email: _auth.currentUser?.email,
            ));
      }
    } else {
      // local storage
      deviceStorage.writeIfNull('IsFirstTime', true);

      // check if it's the first time launching the app
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnboardingScreen());
    }
  }

  /* ==== email & password sign-in, registration ===== */

  // -- [EmailAuthentication] - signIn --
  Future<UserCredential> logInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: "firebaseAuth exception error",
        message: e.code.toString(),
      );
      throw CFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: "firebase exception error",
        message: e.code.toString(),
      );
      throw CFirebaseAuthExceptions(e.code).message;
    } on FormatException catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: "platform exception error",
        message: e.message,
      );
      throw CFormatExceptions(e.message);
    } on PlatformException catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: "platform exception error",
        message: e.code.toString(),
      );
      throw CPlatformExceptions(e.code).message;
    } catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: "An error occurred",
        message: e.toString(),
      );
      throw 'something went wrong! please try again later.';
    }
  }

  // -- [EmailAuthentication] - register --
  Future<UserCredential> signupWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: "firebaseAuth exception error",
        message: e.code.toString(),
      );
      throw CFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: "firebase exception error",
        message: e.code.toString(),
      );
      throw CFirebaseAuthExceptions(e.code).message;
    } on FormatException catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: "platform exception error",
        message: e.message,
      );
      throw CFormatExceptions(e.message);
    } on PlatformException catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: "platform exception error",
        message: e.code.toString(),
      );
      throw CPlatformExceptions(e.code).message;
    } catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: "An error occurred",
        message: e.toString(),
      );
      throw 'something went wrong! please try again!';
    }
  }

  // -- [EmailAuthentication] -- MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: "firebaseAuth exception error",
        message: e.code.toString(),
      );
      throw CFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: "firebase exception error",
        message: e.code.toString(),
      );
      throw CFirebaseAuthExceptions(e.code).message;
    } on FormatException catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: "platform exception error",
        message: e.message,
      );
      throw CFormatExceptions(e.message);
    } on PlatformException catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: "platform exception error",
        message: e.code.toString(),
      );
      throw CPlatformExceptions(e.code).message;
    } catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: "An error occurred",
        message: e.toString(),
      );
      throw 'something went wrong! please try again!';
    }
  }

  /// -- [ReAuthenticate] - re-authenticate user --
  Future<void> reAuthWithEmailAndPassword(String email, String password) async {
    try {
      // create a credential
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      // re-authenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: e.code,
        message: e.message,
      );
      throw CFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: e.code,
        message: e.message,
      );
      throw CFirebaseExceptions(e.code).message;
    } on FormatException catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: 'Format ERROR!',
        message: e.message,
      );
      throw CFormatExceptions(e.message);
    } on PlatformException catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: 'Platform exception!',
        message: e.message,
      );
      throw CPlatformExceptions(e.code).message;
    } catch (e) {
      throw CPopupSnackBar.errorSnackBar(
        title: 'Oh Snap!',
        message: 'an unknown error occurred! please try again later',
      );
    }
  }

  /// -- [EmailVerification] - forgot password --
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: "firebaseAuth exception error",
        message: e.code.toString(),
      );
      throw CFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: "firebase exception error",
        message: e.code.toString(),
      );
      throw CFirebaseAuthExceptions(e.code).message;
    } on FormatException catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: "platform exception error",
        message: e.message,
      );
      throw CFormatExceptions(e.message);
    } on PlatformException catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: "platform exception error",
        message: e.code.toString(),
      );
      throw CPlatformExceptions(e.code).message;
    } catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: "An error occurred",
        message: e.toString(),
      );
      throw 'something went wrong! please try again!';
    }
  }

  /* ===== federated identity & social media sign-in ===== */

  /// -- [GoogleAuthentication] - GOOGLE --
  Future<UserCredential> loginInWithGoogle() async {
    try {
      // trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // once signed in, return the UserCredential Object(class)
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      final exception = CExceptions.fromCode(e.code);
      CPopupSnackBar.customToast(message: 'FIREBASE AUTH ERROR!');
      throw exception.message;
    } catch (_) {
      const exception = CExceptions();
      CPopupSnackBar.customToast(message: 'AUTH ERROR!');
      throw exception.message;
    }
  }

  /// -- [FacebookAuthentication] - FACEBOOK --

  /* ===== ./end federated identity & social media sign-in ===== */
  /// -- [LogoutUser] - valid for any authentication --
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw CFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw CFirebaseExceptions(e.code).message;
    } on FormatException catch (e) {
      throw CFormatExceptions(e.message);
    } on PlatformException catch (e) {
      throw CPlatformExceptions(e.code).message;
    } catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: 'unknown error!',
        message: e.toString(),
      );
      throw 'something went wrong! please try again later';
    }
  }

  /// -- remove user Auth & Firestore account --
  Future<void> deleteAccount() async {
    try {
      await CUserRepo.instance.deleteUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw CFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw CFirebaseExceptions(e.code).message;
    } on FormatException catch (e) {
      throw CFormatExceptions(e.message);
    } on PlatformException catch (e) {
      throw CPlatformExceptions(e.code).message;
    } catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: 'unknown error!',
        message: e.toString(),
      );
      throw 'something went wrong! please try again later';
    }
  }
}
