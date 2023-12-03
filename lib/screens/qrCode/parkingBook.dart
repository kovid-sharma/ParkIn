import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parkin/constants/colors.dart';
import 'package:sizer/sizer.dart';

import '../../controller/jwt_controller.dart';
import '../auth/homescreen.dart';
class ParkingLotBookedScreen extends StatefulWidget {
  const ParkingLotBookedScreen({super.key});

  @override
  State<ParkingLotBookedScreen> createState() => _ParkingLotBookedScreenState();
}

class _ParkingLotBookedScreenState extends State<ParkingLotBookedScreen> {

  @override
  void initState()
  {
    super.initState();

    NavigateFromSplash();
  }
  final jwt=Get.put(JWTController(),permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backLightColor,
        appBar: AppBar(
          title: Text('Qr Entry Successful', style: TextStyle(color: redColor),),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 3.h,),
            Center(
              child: SvgPicture.asset('assets/person_wait.svg',
                width: 60.w,),


            ),
            SizedBox(height: 3.h,),

          ],
        )



    );
  }

  void NavigateFromSplash() async{
    jwt.bookedSeat.value= jwt.bookedSeat.value+1;
    if(jwt.firstTimeTap.value==0)
      jwt.firstTimeTap.value=DateTime.now().millisecondsSinceEpoch;

    print(jwt.bookedSeat.value);
    print(jwt.firstTimeTap.value);
    await Future.delayed(const Duration(milliseconds: 4000));
    Get.off(()=>HomeScreen());
  }
}
