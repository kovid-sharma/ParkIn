import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:parkin/constants/snackbar.dart';
var hiveBox = Hive.box("secrets");
Future<bool> createUserWithEmailAndPassword(String emailAddress, String password) async {
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );

    debugPrint(credential.toString());
    await hiveBox.put("userId", emailAddress);

  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      CustomSnackbar.showFailure('The password provided is too weak.');

    } else if (e.code == 'email-already-in-use') {
      CustomSnackbar.showFailure('The account already exists for that email');
    }
  } catch (e) {
    print(e);
  }
  return true;
}

