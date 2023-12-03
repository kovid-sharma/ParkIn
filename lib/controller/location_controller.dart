
import 'package:book_my_seat/book_my_seat.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

import 'package:geolocator/geolocator.dart';
import 'package:parkin/constants/snackbar.dart';
class LocController extends GetxController {


  TextEditingController lotName= TextEditingController();
  TextEditingController name= TextEditingController();
  TextEditingController maxCapacity= TextEditingController();
  TextEditingController address= TextEditingController();
  TextEditingController landmarks= TextEditingController();
  TextEditingController rowsss=TextEditingController();
  TextEditingController colsss= TextEditingController();
  TextEditingController mCapa= TextEditingController();
  int r=10;
  int c=10;
  int mC=100;
  late List<List<SeatState>> seats;
  double long=123.0;
  double lat= 123.0;
  RxString locationAdd='Okla'.obs;
  List<List<SeatState>> createSeatArray(int rows, int cols) {

    List<List<SeatState>> seatArray = List.generate(
      rows,
          (row) => List<SeatState>.filled(cols, SeatState.unselected),
    );
    seats=seatArray;

    return seatArray;
  }

  Future<String> getAddress(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark firstPlacemark = placemarks.first;
        locationAdd.value='${firstPlacemark.subThoroughfare} ${firstPlacemark.thoroughfare}, ${firstPlacemark.locality}, ${firstPlacemark.administrativeArea} ${firstPlacemark.postalCode}, ${firstPlacemark.country}';
        print("${firstPlacemark.subThoroughfare} ${firstPlacemark.thoroughfare}, ${firstPlacemark.locality}, ${firstPlacemark.administrativeArea} ${firstPlacemark.postalCode}, ${firstPlacemark.country}");
        return "${firstPlacemark.subThoroughfare} ${firstPlacemark.thoroughfare}, ${firstPlacemark.locality}, ${firstPlacemark.administrativeArea} ${firstPlacemark.postalCode}, ${firstPlacemark.country}";
      } else {
        print('je');
        return "Address not found";
      }
    } catch (e) {
      print(e.toString());
      return "Error: $e";
    }
  }
  Future<Position> determinePosition() async {
    print('hello');
    bool serviceEnabled;
    LocationPermission permission;


    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      CustomSnackbar.showFailure('Location services are disabled.');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position x=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    long=x.longitude;
    lat=x.latitude;
    CustomSnackbar.showSucess('We have recorded your coordinates as ${x.longitude} and latitude as ${x.latitude}');
    return x;
  }
}