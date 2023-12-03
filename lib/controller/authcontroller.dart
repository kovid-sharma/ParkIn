import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:parkin/constants/snackbar.dart';

import '../main.dart';
import '../screens/auth/homescreen.dart';
var hiveBox = Hive.box("secrets");
Future<bool> createUserWithEmailAndPassword(String emailAddress, String password, String name) async {
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );

    debugPrint(credential.toString());
    await hiveBox.put("userId", emailAddress);
    await hiveBox.put("Name",name);

    CustomSnackbar.showSucess('Signing you Up!');
    //await Future.delayed(const Duration(milliseconds: 4000));
    Get.offAll(HomePage());

  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      CustomSnackbar.showFailure('The password provided is too weak.');

    } else if (e.code == 'email-already-in-use') {
      CustomSnackbar.showFailure('The account already exists for that email');
    }
  } catch (e) {
    print(e);
    CustomSnackbar.showFailure(e.toString());
  }
  return true;
}

