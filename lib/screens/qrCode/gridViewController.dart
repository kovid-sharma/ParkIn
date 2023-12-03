import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/model/models.dart';

class LocationsController extends GetxController {
  final RxList<Location> locations = <Location>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchLocations();
  }

  Future<void> fetchLocations() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('Locations').get();

      locations.assignAll(snapshot.docs.map((doc) => Location.fromMap(doc.data())).toList());
    } catch (error) {
      print('Error fetching locations: $error');
    }
  }
}
