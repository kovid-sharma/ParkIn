import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../controller/jwt_controller.dart';
import '../../widgets/custom_icon.dart';
class GridAndLoc extends StatefulWidget {
  const GridAndLoc({super.key});

  @override
  State<GridAndLoc> createState() => _GridAndLocState();
}

class _GridAndLocState extends State<GridAndLoc> {
  final authController = Get.put(JWTController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backLightColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3.h,),
          Center(
            child: SizedBox(
              height: 20.h,
              child: CustomIcon(repeat:true),
            ),
          ),
          SizedBox(height: 3.h,),




        ],
      ),
    );
  }
}

