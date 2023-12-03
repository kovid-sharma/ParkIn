import 'dart:typed_data';

import 'package:book_my_seat/book_my_seat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:parkin/constants/colors.dart';
import 'package:parkin/controller/jwt_controller.dart';
import 'package:parkin/screens/qrCode/parkingBook.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/custom_icon.dart';

class QrEntryPage extends StatefulWidget {
  QrEntryPage({super.key,required this.r, required this.c, required this.seats, required this.add});
  int r;
  int c;
  List<List<SeatState>> seats;
  String add;


  @override
  State<QrEntryPage> createState() => _QrEntryPageState();
}

class _QrEntryPageState extends State<QrEntryPage> {


  final jwt= Get.put(JWTController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backLightColor,
        appBar: AppBar(
          title: Text('QR Code For Entry', style: TextStyle(color: redColor),),
        ),
        body: Column(
          children: [
            SizedBox(height: 3.h,),
            Center(
              child: SizedBox(
                height: 20.h,
                child: CustomIcon(repeat:true),
              ),
            ),
            SizedBox(height: 1.h,),
            Expanded(
              child: Container(
                height: 60.h,
                child: MobileScanner(
                  // fit: BoxFit.contain,
                  controller: MobileScannerController(
                    detectionSpeed: DetectionSpeed.normal,
                    facing: CameraFacing.back,

                  ),
                  onDetect: (capture) async{
                    final List<Barcode> barcodes = capture.barcodes;
                    final Uint8List? image = capture.image;
                    String xy="0 0";
                    for (final barcode in barcodes) {
                      debugPrint('Barcode found! ${barcode.rawValue}');
                      xy= barcode.rawValue??"0 0";
                    }
                    CollectionReference docs = FirebaseFirestore.instance.collection('Documents');

                    // Retrieve the specific document
                    DocumentSnapshot<Object?> documentSnapshot = await docs.doc(widget.add).get();
                    Object? fieldValue = documentSnapshot.get('your_field_name');
                    print(fieldValue.toString());

                    CollectionReference locationsCollection = FirebaseFirestore.instance.collection('Locations');



                      // Splitting the string by space
                      List<String> words = xy.split(' ');


                      int? x= int.tryParse(words[0]);
                      int? y= int.tryParse(words[1]);



                    int rowIndex=x??0;
                    int colIndex=y??0;

                    String newSeat= "$rowIndex $colIndex";
                    await locationsCollection.doc(fieldValue.toString()).update({
                      'selectedSeats': FieldValue.arrayUnion([newSeat]),
                    });
                    jwt.selSEATS.add("${widget.add} $rowIndex $colIndex");

                    Get.off(()=>ParkingLotBookedScreen());
                  },
                ),
              ),
            ),
            Expanded(child: SizedBox()),
          ],
        ),
    );
  }

}
