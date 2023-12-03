import 'package:book_my_seat/book_my_seat.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:parkin/constants/snackbar.dart';
import 'package:parkin/controller/location_controller.dart';
import 'package:parkin/screens/svg_screens.dart';
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
  final locController= Get.put(LocController());
  String xy='Delhi';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backLightColor,
      body: SingleChildScrollView(
        child: Column(
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
              'LayOut Display of your Parking',
              style: TextStyle(
                color:redColor,
                fontSize: 27,
              ),
            ),
            SizedBox(height: 3.h,),
            Row(
              children: [
                Expanded(child: SizedBox(),),
                SeatLayoutWidget(
                  onSeatStateChanged: (rowIndex, colIndex, updatedSeatState) {
                    print("tapped $rowIndex $colIndex $updatedSeatState");
                    locController.seats[rowIndex][colIndex]=updatedSeatState;
                  },
                  stateModel: SeatLayoutStateModel(
                    rows: int.parse(locController.rowsss.text),
                    cols: int.parse(locController.colsss.text),
                    seatSvgSize: 30,
                    pathUnSelectedSeat: 'assets/seat_unselected.svg',
                    pathSelectedSeat: 'assets/seat_selected.svg',
                    pathSoldSeat: 'assets/seat_sold.svg',
                    pathDisabledSeat: 'assets/seat_disabled.svg',
                    currentSeatsState: locController.seats


                    ,
                  ),
                ),
                Expanded(child: SizedBox(),),
              ],
            ),


            SizedBox(height: 3.h,),
            Center(
                child: ElevatedButton(
                  style:ButtonStyle(
                    shape: MaterialStateProperty.resolveWith((states){
                      return RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      );
                    },
                    ),
                    side: MaterialStateProperty.resolveWith((states){
                      if(states.contains(MaterialState.pressed))
                      {
                        return const BorderSide(color: Colors.green);
                      }
                      return BorderSide(color: redLightColor);
                    }

                    ),

                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.green;
                      }
                      return Color(0xffff2a2a);
                    }),

                  ),

                  onPressed: ()async
                  {
                    Position x=await locController.determinePosition();
                    xy=await locController.getAddress(x.latitude, x.longitude);


                  }, child:
                const Text('Permit Location Access',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                )
            ),
            SizedBox(height: 3.h,),
            Center(
                child: ElevatedButton(
                  style:ButtonStyle(
                    shape: MaterialStateProperty.resolveWith((states){
                      return RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      );
                    },
                    ),
                    side: MaterialStateProperty.resolveWith((states){
                      if(states.contains(MaterialState.pressed))
                      {
                        return const BorderSide(color: Colors.green);
                      }
                      return BorderSide(color: redLightColor);
                    }

                    ),

                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.green;
                      }
                      if(states.contains(MaterialState.hovered))
                        {
                          return Colors.greenAccent;
                        }
                      return Color(0xffff2a2a);
                    }),

                  ),

                  onPressed: ()
                  {
                    Get.to(()=>SvgConfirmScreen(location: xy,));


                  }, child:
                const Text('Submit Your Registration',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                )
            ),
        
        
          ],
        ),
      ),
    );
  }
}

