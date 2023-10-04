import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../widgets/custom_icon.dart';
class LocRegister extends StatefulWidget {
  const LocRegister({Key? key}) : super(key: key);

  @override
  State<LocRegister> createState() => _LocRegisterState();
}

class _LocRegisterState extends State<LocRegister> {
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
              child: CustomIcon(repeat:false),
            ),
          ),
          Center(
            child: Container(
              height: 48,
              width: 88.w,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(30)),
              child: const TextField(
                showCursor: false,
                decoration: InputDecoration(
                    hintText: "Search parking locations",
                    hintStyle: TextStyle(fontSize: 13, color: Colors.black45),
                    contentPadding: EdgeInsets.only(left: 10, top: 11),
                    prefixIcon: Icon(
                      Icons.search_outlined,
                      color: Colors.black45,
                      size: 35,
                    ),
                    border: InputBorder.none),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
