import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:parkin/constants/colors.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/custom_icon.dart';

class QrEntryPage extends StatefulWidget {
  const QrEntryPage({super.key});

  @override
  State<QrEntryPage> createState() => _QrEntryPageState();
}

class _QrEntryPageState extends State<QrEntryPage> {




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
            Container(
              height: 60.h,
              width: 80.w,
              child: Row(

                children: [
                  Expanded(child: SizedBox()),
                  MobileScanner(
                    // fit: BoxFit.contain,
                    controller: MobileScannerController(
                      detectionSpeed: DetectionSpeed.normal,
                      facing: CameraFacing.back,

                    ),
                    onDetect: (capture) {
                      final List<Barcode> barcodes = capture.barcodes;
                      final Uint8List? image = capture.image;
                      for (final barcode in barcodes) {
                        debugPrint('Barcode found! ${barcode.rawValue}');
                      }
                    },
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
            ),
            Expanded(child: SizedBox()),
          ],
        ),
    );
  }

}
