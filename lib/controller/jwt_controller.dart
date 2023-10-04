import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class JWTController extends GetxController{
  RxBool isAuth= false.obs;
  String? userId;
  var hiveBox = Hive.box("secrets");
  Future<String?> getUserId () async {
    if (userId != null) {
      return userId!;
    }
    debugPrint('Getting user id');
    userId = await hiveBox.get("userId");

    return userId;
  }
  @override
  void onInit() async {
    super.onInit();
    userId ??= await getUserId();
    if (userId == null) {
      debugPrint("NO AUTH");
    } else {
      debugPrint("AUTH");
      isAuth.value = true;
    }
  }
}