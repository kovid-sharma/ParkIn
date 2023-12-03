import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkin/constants/colors.dart';
import 'package:parkin/constants/snackbar.dart';
import 'package:parkin/screens/auth/location_register.dart';
import 'package:parkin/screens/qrCode/grid_locations.dart';
import 'package:sizer/sizer.dart';

import '../../controller/jwt_controller.dart';
import '../../widgets/custom_icon.dart';
import '../qrCode/exit_qr.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final authController = Get.put(JWTController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: authController.bookedSeat.value!=0? CuteFloatingActionButton():
          Container(),

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
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text('Hello, ${authController.name??'User'}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                color: gray
              ),
            ),
          ),
          const Padding(
           padding: EdgeInsets.only(left:30.0),
           child: Text('Where would you like\n to go?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30
              ),
            ),
         ),
          SizedBox(height: 2.4.h,),
          Center(
            child: Container(
              height: 48,
              width: 88.w,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(30)),
              child: TextField(
                onEditingComplete: ()
                {
                  CustomSnackbar.showSucess('The Searched String is not available in our Landmarks');
                },
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
          SizedBox(height: 5.h,),
         Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left:30.0),
                child: Text('Available lots',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                  ),
                ),
              ),
             GestureDetector(
               onTap: ()
               {
                 Get.to(()=>LocationsScreen());
               },
               child: Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: Text('See all',
                    style: TextStyle(
                        fontSize: 14,
                      color: redColor,
                    ),
                  ),
                ),
             ),
            ],
          ),
          SizedBox(height: 2.h,),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left:7.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 25.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(30),
                        image: const DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/image2.jpg',
                        ),
                      ),
                    ),
                    ),
                    const Text('Connaught Place',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                    Text('Delhi',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: gray
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left:7.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 25.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(30),
                        image: const DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/image1.jpg',
                          ),
                        ),
                      ),
                    ),
                    const Text('Crown Interiorz',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                    Text('Faridabad',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: gray
                      ),
                    ),
            ],
          ),),
        ]
        ),
        const Expanded(child: SizedBox()),
          Center(
            child: GestureDetector(
              onTap: ()
              {
                Get.to(()=>LocRegister());
              },
              child: Text(
                authController.isSpaceRegistered.value?
                'Check Status of your Space':'Add your Space',
                style: TextStyle(
                  color: redColor,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          Center(
            child: Padding(padding: EdgeInsets.only(top: 5),
              child: Text(authController.isSpaceRegistered.value?'Check Status of your space registration':'Do you wish to register your parking space?',
                style: TextStyle(
                    fontSize: 14,
                    color: gray
                ),
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
class CuteFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.red,
      onPressed: () {
        Get.to(()=>ExitQRScreen());
      },
      tooltip: 'Exit QR',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.qr_code, size: 24.0, color: Colors.white),
          SizedBox(height: 8.0),
          Text(
            'Exit QR',
            style: TextStyle(fontSize: 10.0, color: Colors.white),
          ),
        ],
      ),
    );
  }
}