import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:parkin/constants/colors.dart';
import 'package:parkin/controller/jwt_controller.dart';
import 'package:sizer/sizer.dart';

import '../constants/model/models.dart';
import '../controller/location_controller.dart';
import '../widgets/custom_icon.dart';
import 'auth/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class SvgConfirmScreen extends StatefulWidget {
  SvgConfirmScreen({super.key,required this.location});
  String location;

  @override
  State<SvgConfirmScreen> createState() => _SvgConfirmScreenState();
}

class _SvgConfirmScreenState extends State<SvgConfirmScreen> {
  final locController= Get.put(LocController());
  final jwt= Get.put(JWTController(),permanent: true);
  @override
  void initState()
  {
    super.initState();
    print(locController.rowsss.text);
    locController.r=int.tryParse(locController.rowsss.text)??10;
    locController.c=int.tryParse(locController.colsss.text)??10;
    locController.mC=int.tryParse(locController.mCapa.text)??10;
    NavigateFromSplash();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backLightColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 3.h,),
          Center(
            child: SizedBox(
              height: 20.h,
              child: CustomIcon(repeat:true),
            ),
          ),
          SizedBox(height: 1.h,),
          Text(
            'Please sit tight while we reach your location to verify.',
            style: TextStyle(
              color:redColor,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 5.h,),

          Center(
            child: SvgPicture.asset('assets/person_wait.svg',
            width: 60.w,),


          ),
          Expanded(
            child:Text(widget.location),
          )



        ],
      ),

    );
  }
  void NavigateFromSplash() async{
    PendingLocation pendingLocation = PendingLocation(
      lotName: locController.lotName.text,
      name: locController.name.text,
      maxCapacity: 100,
      rows: locController.r,
      cols: locController.c,
      latitude: locController.lat,
      longitude: locController.long,
      address: widget.location,
      selectedSeats: [

        // Add more pairs as needed
      ],
    );

    FirebaseFirestore.instance.collection('PendingLocations').add(pendingLocation.toMap());
    jwt.isSpaceRegistered.value=true;
    await Future.delayed(const Duration(milliseconds: 8000));
    Get.offAll(()=> HomeScreen());
  }
}
