import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../constants/snackbar.dart';
import '../../controller/location_controller.dart';
import '../../widgets/custom_icon.dart';
import 'grid_showAND_loc_screen.dart';
class LocRegister extends StatefulWidget {
  const LocRegister({Key? key}) : super(key: key);

  @override
  State<LocRegister> createState() => _LocRegisterState();
}

class _LocRegisterState extends State<LocRegister> {
  var locController = Get.put(LocController());

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                  padding: EdgeInsets.only(left: 30.0,bottom: 5),
                  child: Text('Parking Lot Name',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 48,
                    width: 88.w,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(30)),
                    child: TextField(
                      controller: locController.lotName,
                      showCursor: false,
                      decoration: InputDecoration(
                          hintText: "Aman's Parking",
                          hintStyle: TextStyle(fontSize: 13, color: Colors.black45),
                          contentPadding: EdgeInsets.only(left: 12, top: 1),
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 30.0,bottom: 5),
                  child: Text('Name',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 48,
                    width: 88.w,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(30)),
                    child: TextField(
                      controller: locController.name,
                      showCursor: false,
                      decoration: InputDecoration(
                          hintText: "Aman Kulkarni",
                          hintStyle: TextStyle(fontSize: 13, color: Colors.black45),
                          contentPadding: EdgeInsets.only(left: 12, top: 1),
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 30.0,bottom: 5),
                  child: Text('Max Capacity',
                    style: TextStyle(
                        fontWeight:FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 48,
                    width: 88.w,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(30)),
                    child: TapRegion(
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      child: TextField(
                        controller: locController.mCapa,
                       // keyboardType:  TextInputType.numberWithOptions(signed: true, decimal: true),
                        keyboardType: TextInputType.number,
                        showCursor: false,
                        decoration: InputDecoration(
                            hintText: "5",
                            hintStyle: TextStyle(fontSize: 13, color: Colors.black45),
                            contentPadding: EdgeInsets.only(left: 12, top: 1),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
      
              ],
            ),
      
            SizedBox(height: 3.h,),
      
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 30.0,bottom: 5),
                      child: Text('Total Rows',
                        style: TextStyle(
                            fontWeight:FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Expanded(child: SizedBox()),
                    Expanded(child: SizedBox()),
                    Center(
                      child: Container(
                        height: 48,
                        width: 44.w,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(30)),
                        child: TapRegion(
                          onTapOutside: (event) => FocusScope.of(context).unfocus(),
                          child: TextField(
                            controller: locController.rowsss,
                            // keyboardType:  TextInputType.numberWithOptions(signed: true, decimal: true),
                            keyboardType: TextInputType.number,
                            showCursor: false,
                            decoration: InputDecoration(
                                hintText: "4",
                                hintStyle: TextStyle(fontSize: 13, color: Colors.black45),
                                contentPadding: EdgeInsets.only(left: 12, top: 1),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
                SizedBox(height: 1.h,),

                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 30.0,bottom: 5),
                      child: Text('Total Cols',
                        style: TextStyle(
                            fontWeight:FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black
                        ),
                      ),
                    ),

                    Expanded(child: SizedBox()),
                    Expanded(child: SizedBox()),
                    Expanded(child: SizedBox()),
                    Center(
                      child: Container(
                        height: 48,
                        width: 44.w,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(30)),
                        child: TapRegion(
                          onTapOutside: (event) => FocusScope.of(context).unfocus(),
                          child: TextField(
                            controller: locController.colsss,
                            // keyboardType:  TextInputType.numberWithOptions(signed: true, decimal: true),
                            keyboardType: TextInputType.number,
                            showCursor: false,
                            decoration: InputDecoration(
                                hintText: "5",
                                hintStyle: TextStyle(fontSize: 13, color: Colors.black45),
                                contentPadding: EdgeInsets.only(left: 12, top: 1),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),

      
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 30.0,bottom: 5),
                  child: Text('Landmarks',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 48,
                    width: 88.w,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(30)),
                    child: TapRegion(
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      child: const TextField(
                        // keyboardType:  TextInputType.numberWithOptions(signed: true, decimal: true),
                        keyboardType: TextInputType.text,
                        showCursor: false,
                        decoration: InputDecoration(
                            hintText: "(optional)",
                            hintStyle: TextStyle(fontSize: 13, color: Colors.black45),
                            contentPadding: EdgeInsets.only(left: 12, top: 1),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
      
              ],
            ),
      
            Expanded(child: SizedBox()),
            Column(
              children: [
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
      
                      onPressed: ()
                      {
                        if (locController.name.text.isEmpty) {
                          CustomSnackbar.showFailure("Please enter user name ");
                        } else if (locController.lotName.text.isEmpty) {
                          CustomSnackbar.showFailure("Please enter correctlot name ");
                        } else if(locController.rowsss.text.isEmpty || locController.colsss.text.isEmpty)
                          {
                            CustomSnackbar.showFailure('Please enter rows and columns before we build your parking layout');
                          }
                          else {
                            locController.createSeatArray(int.parse(locController.rowsss.text), int.parse(locController.colsss.text));

                          Get.to(()=>GridAndLoc());

                        }

                      }, child:
                   const Text('Continue',
                       style: TextStyle(
                         color: Colors.white
                       ),
                  ),
                )
                )
      
              ],
            ),
            const Expanded(child: SizedBox()),
           const Expanded(child: SizedBox()),
      
          ],
        ),
      );
  }
}
