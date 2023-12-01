import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkin/controller/jwt_controller.dart';
import 'package:parkin/screens/parkin/signin.dart';
import 'package:parkin/screens/parkin/signup.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../widgets/custom_icon.dart';
import '../auth/homescreen.dart';

class CommonAuthScreen extends StatefulWidget {
  const CommonAuthScreen({Key? key}) : super(key: key);

  @override
  State<CommonAuthScreen> createState() => _CommonAuthScreenState();
}

class _CommonAuthScreenState extends State<CommonAuthScreen>
    with SingleTickerProviderStateMixin {
  final authController = Get.put(JWTController());

  @override
  void initState() {
    authController.tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
          backgroundColor: backLightColor,
          body: Container(
              height: size.height,
              decoration: BoxDecoration(

              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        height: 15.h,
                        child: CustomIcon(repeat:false),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: size.height / 1.5,
                        margin: const EdgeInsets.only(),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey,blurRadius: 1)
                          ]
                        ),
                        child: Column(
                          children: [
                            Container(
                              color: Colors.white,
                              height: 45,
                              margin: const EdgeInsets.only(
                                  left: 25, right: 25, top: 30),
                              child: TabBar(

                                controller: authController.tabController,
                                indicatorPadding: EdgeInsets.zero,
                                labelPadding: EdgeInsets.zero,
                                indicator: BoxDecoration(

                                    borderRadius: BorderRadius.circular(90),
                                    color:Colors.redAccent),
                                labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    // color: AppColor.blackColor,
                                    fontSize: 16),
                                labelColor: Colors.black87,

                                unselectedLabelStyle: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16, color: Colors.redAccent),
                                tabs: const [
                                  Tab(
                                    text: "SIGN IN",
                                  ),
                                  Tab(
                                    text: "SIGN UP",
                                  ),
                                  // Tab(text: 'Sign Up'),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              // color: Colors.white,
                              // height: 200,
                              child: TabBarView(
                                controller: authController.tabController,
                                children: const [
                                  SignIn(),
                                  SignUp(),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
          ),
        ));
  }
}
