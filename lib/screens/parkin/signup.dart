import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parkin/controller/authcontroller.dart';
import 'package:parkin/controller/jwt_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:parkin/main.dart';

import '../../constants/colors.dart';
import '../../constants/custom_text_field.dart';
import '../../constants/form_heading_text.dart';
import '../../constants/snackbar.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final auth = FirebaseAuth.instance;
  User? user;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  Future<void> _handleSignIn() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    debugPrint(googleUser?.email);
    if (googleUser != null) {
      try {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleUser
            .authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        user = userCredential.user;
        await hiveBox.put('Name',googleUser.displayName.toString());
        await hiveBox.put("userId", authController.emailController.text);
       CustomSnackbar.showSucess("Signing you UP!");
       authController.isAuth.value=true;
       Get.offAll(()=>HomePage());
      }
      catch(e)
    {
      debugPrint(e.toString());
      CustomSnackbar.showFailure(e.toString());
    }
      authController.appleRegister(
          googleUser.email, googleUser.id, googleUser.photoUrl.toString(),
          googleUser.displayName.toString());
    }
  }

  final List<String> _genders = ['    Sedan', '    SUV', '    HatchBack'];
  String _selectedGender='    Sedan';
  final authController = Get.put(JWTController());
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
              headings: "Name",
            ),
            MyCustomTextfiled(
              controller: authController.nameController,
            ),
            SizedBox(
              height: size.height * .01,
            ),
            FormHeadingText(
              color: Colors.black,
              // headings: "E-mail / Phone no",
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
            //  color: signInHeading,
              headings: "Choose Car Type",
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                //color: Color(0xffF2F2F2) ,
                decoration: BoxDecoration(
                    color: const Color(0xffF2F2F2),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    style: const TextStyle(
                      backgroundColor:  Color(0xffF2F2F2), // Set the dropdown's background color here
                    ),
                    value: _selectedGender,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedGender = newValue!;
                      });
                    },
                    items: _genders.map<DropdownMenuItem<String>>((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: FormHeadingText(
                          //color: signInHeading,
                          headings:gender,
                        ),
                      );
                    }).toList(),
                    hint: const Text('Select Gender'), // Hint text for the dropdown
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * .01,
            ),
            FormHeadingText(
              //color: signInHeading,
              headings: "Password",
            ),
            MyCustomTextfiled(
             controller: authController.passwordController,
            ),
            SizedBox(
              height: size.height * .01,
            ),
            FormHeadingText(
             // color: signInHeading,
              headings: "Confirm Password",
            ),
            MyCustomTextfiled(
              obsc: true,
              controller: authController.confirmPasswordController,
            ),

            SizedBox(
              height: size.height * .03,
            ),

            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () async {

                  if (authController.nameController.text.isEmpty) {
                    CustomSnackbar.showFailure("Please enter user name ");
                  } else if (authController.emailController.text.isEmpty || !authController.emailController.text.isEmail) {
                    CustomSnackbar.showFailure("Please enter correct email ");
                  }   else if (authController.passwordController.text != authController.confirmPasswordController.text) {
                    CustomSnackbar.showFailure("Password and confirm password should be same");
                  } else {
                    createUserWithEmailAndPassword(authController.emailController.text, authController.passwordController.text,authController.nameController.text);
                  }
                },
                child:Obx(() {
                  return Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: MediaQuery.of(context).size.width / 2.3,
                    decoration: BoxDecoration(
                      gradient: buttonGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: authController.isUserRegistering.value
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : Text(
                      "SIGN UP",
                      style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w700),
                    ),
                  );
                })

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
      ),
    );
  }
}
