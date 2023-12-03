import 'package:book_my_seat/book_my_seat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkin/constants/snackbar.dart';
import 'package:parkin/controller/jwt_controller.dart';
import 'package:parkin/screens/auth/homescreen.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../widgets/custom_icon.dart';
class BookingScreen extends StatefulWidget {
  BookingScreen({super.key, required this.r, required this.c, required this.seats, required this.add});
  int r;
  int c;
  List<List<SeatState>> seats;
  String add;


  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final jwt=Get.put(JWTController(),permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pre Booking Screen',
          style: TextStyle(
              color: redColor
          ),
        ),
      ),
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
            Center(
              child: Text(
                'Choose Your Parking Space By Selecting',
                style: TextStyle(
                  color:redColor,
                  fontSize: 27,
                ),
              ),
            ),
            SizedBox(height: 3.h,),
            Row(
              children: [
                Expanded(child: SizedBox(),),
                SeatLayoutWidget(
                  onSeatStateChanged: (rowIndex, colIndex, updatedSeatState) async {
                    print("tapped $rowIndex $colIndex $updatedSeatState");
                    if(updatedSeatState==SeatState.selected) {
                      CollectionReference docs = FirebaseFirestore.instance.collection('Documents');

                      // Retrieve the specific document
                      DocumentSnapshot<Object?> documentSnapshot = await docs.doc(widget.add).get();
                      Object? fieldValue = documentSnapshot.get('your_field_name');
                      print(fieldValue.toString());

                      CollectionReference locationsCollection = FirebaseFirestore.instance.collection('Locations');

                      String newSeat= "$rowIndex $colIndex";
                      await locationsCollection.doc(fieldValue.toString()).update({
                        'selectedSeats': FieldValue.arrayUnion([newSeat]),
                      });

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {

                          return UnDismissableAlertDialog();
                        },
                      );
                    }
                    else
                      {
                        CustomSnackbar.showFailure('This seat is already booked');
                        setState(() {
                          widget.seats[rowIndex][colIndex]=SeatState.selected;
                        });
                      }

                  },
                  stateModel: SeatLayoutStateModel(
                    rows: widget.r,
                    cols: widget.c,
                    seatSvgSize: 30,
                    pathUnSelectedSeat: 'assets/seat_unselected.svg',
                    pathSelectedSeat: 'assets/seat_selected.svg',
                    pathSoldSeat: 'assets/seat_sold.svg',
                    pathDisabledSeat: 'assets/seat_disabled.svg',
                    currentSeatsState: widget.seats,
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
                      if(states.contains(MaterialState.hovered))
                      {
                        return Colors.greenAccent;
                      }
                      return Color(0xffff2a2a);
                    }),

                  ),

                  onPressed: ()
                  {

                    CustomSnackbar.showSucess('Please choose your seat');

                  }, child:
                const Text('Choose your seat',
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
class UnDismissableAlertDialog extends StatelessWidget {
  final jwt=Get.put(JWTController(),permanent: true);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Returning false prevents the dialog from being dismissed
        return false;
      },
      child: AlertDialog(
        title: Text('Congrats!You Have Booked Your Parking Space',

          style: TextStyle(
            color: redColor
          ),
        ),
        content: Text('The Space is Booked successfully for you!'),
        actions: [
          ElevatedButton(
            onPressed: () {
              jwt.bookedSeat.value= jwt.bookedSeat.value+1;
              if(jwt.firstTimeTap.value==0)
              jwt.firstTimeTap.value=DateTime.now().millisecondsSinceEpoch;

              print(jwt.bookedSeat.value);
              print(jwt.firstTimeTap.value);

              Get.offAll(()=>HomeScreen());// Close the dialog when the button is pressed
            },
            child: Text('Ok'),
          ),
        ],
      ),
    );
  }
}
