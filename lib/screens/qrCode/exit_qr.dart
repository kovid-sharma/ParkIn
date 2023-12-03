import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:parkin/controller/jwt_controller.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../widgets/custom_icon.dart';
import '../Payment_screen.dart';
class ExitQRScreen extends StatefulWidget {
  const ExitQRScreen({super.key});

  @override
  State<ExitQRScreen> createState() => _ExitQRScreenState();
}

class _ExitQRScreenState extends State<ExitQRScreen> {
  final jwt= Get.put(JWTController(),permanent: true);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: backLightColor,
      appBar: AppBar(
        title: Text('QR Code For Exit', style: TextStyle(color: redColor),),
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

                  for (final barcode in barcodes) {
                    debugPrint('Barcode found! ${barcode.rawValue}');

                  }
                  for(int i=0;i<jwt.selSEATS.length;i++)
                    {


                      List<String> words = jwt.selSEATS[i].split(' ');
                      String add= words[0];
                      String toDel= '${words[1]} ${words[2]}';
                      CollectionReference docs = FirebaseFirestore.instance.collection('Documents');

                      // Retrieve the specific document
                      DocumentSnapshot<Object?> documentSnapshot = await docs.doc(add).get();
                      Object? fieldValue = documentSnapshot.get('your_field_name');
                      print(fieldValue.toString());

                      CollectionReference locationsCollection = FirebaseFirestore.instance.collection('Locations');
                      await locationsCollection.doc(fieldValue.toString()).update({
                        'selectedSeats': FieldValue.arrayRemove([toDel]),
                      });
                    }
                  jwt.selSEATS.clear();
                  Get.off(()=>PaymentScreen());
                },
              ),
            ),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    );;
  }
}
