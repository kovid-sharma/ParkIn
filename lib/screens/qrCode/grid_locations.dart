import 'package:book_my_seat/book_my_seat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkin/constants/colors.dart';

import '../../constants/model/models.dart';
import 'QrEntryPage.dart';
import 'booking_screen.dart';
import 'gridViewController.dart';

class LocationsScreen extends StatelessWidget {
  final LocationsController controller = Get.put(LocationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backLightColor,
      appBar: AppBar(
        title: Text('Locations',
        style: TextStyle(
            color: redColor
        ),
        ),
      ),
      body: Obx(
            () => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: controller.locations.length,
          itemBuilder: (context, index) {
            final location = controller.locations[index];
            late List<List<SeatState>> seats=
            List.generate(
              location.rows,
                  (row) => List<SeatState>.filled(location.cols, SeatState.unselected),
            );
            List<String> selecetdSeats=  controller.locations[index].selectedSeats;

            for (String str in selecetdSeats) {


              // Splitting the string by space
              List<String> words = str.split(' ');


              int? x= int.tryParse(words[0]);
              int? y= int.tryParse(words[1]);
              seats[x??0][y??0]=SeatState.selected;

              print('----------------------');
            }
            return buildLocationCard(location,seats);
          },
        ),
      ),
    );
  }

  Widget buildLocationCard(Location location,List<List<SeatState>> seats) {
    return Card(
      elevation: 5.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: ()
              {
                Get.to(()=>BookingScreen(r:location.rows,c:location.cols,seats: seats,add: location.address,));
              },
              child: Container(
                child: Image.network(
                  location.image,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(location.name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                Text(location.lotName,style: TextStyle(fontSize: 11,)),
                Text('Capacity: ${location.maxCapacity}',style: TextStyle(fontSize: 11,)),
                Text('Address: ${location.address}',style: TextStyle(fontSize: 11,)),
                // Add more details as needed
              ],
            ),
          ),

          Padding(padding: const EdgeInsets.all(0),
            child: Center(
              child: IconButton(
                icon: Icon(Icons.qr_code,size: 20,),
                onPressed: ()
                {
                  Get.off(()=>QrEntryPage(r:location.rows,c:location.cols,seats: seats,add: location.address,));
                },
              ),
            ),
          )


        ],
      ),
    );
  }
}
