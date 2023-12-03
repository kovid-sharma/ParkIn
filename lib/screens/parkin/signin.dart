import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:parkin/constants/colors.dart';
import 'package:parkin/constants/snackbar.dart';
import 'package:parkin/controller/jwt_controller.dart';
import 'package:parkin/screens/auth/homescreen.dart';

import '../../constants/custom_text_field.dart';
import '../../constants/form_heading_text.dart';
import '../../main.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'displayName'
    ],
  );
  String trimBeforeAtSymbol(String input) {
    int atIndex = input.indexOf('@');

    // Check if @ symbol is present in the string
    if (atIndex != -1) {
      // Trim the string before the @ symbol
      return input.substring(0, atIndex);
    }

    // If @ symbol is not found, return the original string
    return input;
  }
  var hiveBox = Hive.box("secrets");
  final authController = Get.find<JWTController>();
  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      debugPrint(googleUser?.email);
      if (googleUser != null) {
        CustomSnackbar.showFailure('Please Sign Up before Sigining In');
      }
      else {
        CustomSnackbar.showSucess('Signed in user ${googleUser?.displayName}');
        Get.offAll(HomeScreen());
      }
    }
    catch(e)
    {
      CustomSnackbar.showFailure('Please Sign Up before Sigining In');
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                FormHeadingText(
                    color: Colors.black,
                   headings: "E-mail",
                ),
                MyCustomTextfiled(
                inputType: TextInputType.emailAddress,
                 controller: authController.emailController,
                ),
                SizedBox(
                height: size.height * .01,
                ),
                FormHeadingText(
                  headings: "Password",
                ),
                MyCustomTextfiled(
                  obsc: true,
                  //inputType: TextInputType.visiblePassword,
                 controller: authController.passwordController,
                ),
            SizedBox(
              height: size.height * .05,
            ),
               Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () async {
                  try {
                    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: authController.emailController.text,
                        password: authController.passwordController.text
                    );
                    await hiveBox.put('Name',trimBeforeAtSymbol(authController.emailController.text));
                    CustomSnackbar.showSucess('Signing you IN');
                    await hiveBox.put("userId", authController.emailController.text);

                    authController.isAuth.value=true;

                    Get.offAll(()=>HomePage());
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      CustomSnackbar.showFailure('No user found for that email.');
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      CustomSnackbar.showFailure('Wrong password');
                      print('Wrong password provided for that user.');
                    }
                  }
                },
                child:
                  Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: MediaQuery.of(context).size.width / 2.3,
                    decoration: BoxDecoration(

                     gradient: buttonGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:

                        Text(
                      "SIGN IN",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        // color: AppColor.blackColor,
                        fontSize: 16,
                    )),
                  ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                "OR",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w200, ),
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Center(
              child: Container(
                width: 200,
                // margin: const EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: ()async{
                        _handleSignIn();
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 15,
                        backgroundImage: const CachedNetworkImageProvider("https://cdn-icons-png.flaticon.com/512/2991/2991148.png"),
                      ),
                    ),


                  ],
                ),
              ),

            ),
              ],
          ),
    )
    );
  }
}
