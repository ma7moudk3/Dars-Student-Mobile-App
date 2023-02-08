

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../constants/exports.dart';

class GoogleSignInHelper {
  static final GoogleSignIn googleSignIn = GoogleSignIn();
  static GoogleSignInAccount? user;
  static GoogleSignInAccount getUser() {
    return user!;
  }

  static Future<GoogleSignInAccount?> googleLogin() async {
    try {
      await googleLogout();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        if (Get.isDialogOpen!) {
          Get.back();
        }
        return null;
      }
      user = googleUser;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (error) {
      log("Exception $error");
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }
    return getUser();
  }

  static Future googleLogout() async {
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
    }
  }
}

class FacebookSignInHelper {
  static Map<String, dynamic> userData = {};

  static Future<Map<String, dynamic>> facebookLogin() async {
    final LoginResult loginResult = await FacebookAuth.instance.login(
      permissions: ['email', 'public_profile', 'user_birthday'],
      // loginBehavior: LoginBehavior.dialogOnly,
    );

    if (loginResult.accessToken != null) {
      userData = await FacebookAuth.instance.getUserData();
      userData["accessToken"] = loginResult.accessToken!.token;
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      log("ASd");
      log(userCredential.user!.providerData[0].phoneNumber.toString());
    } else {
      log("ASd");
    }
    return userData;
  }

  static Future facebookLogout() async {
    await FacebookAuth.instance.logOut();
    await FirebaseAuth.instance.signOut();
  }
}

class AppleSignInHelper {
  static Future appleLogin() async {}
}
