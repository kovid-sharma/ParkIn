import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
class JWTController extends GetxController{
  TabController? tabController;
  TextEditingController nameController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final dobController = TextEditingController();
  RxBool isAuth= false.obs;
  RxBool isUserRegistering = false.obs;
  String? userId;
  String? name;
  RxBool isSpaceRegistered=false.obs;
  RxInt rows=10.obs;
  RxInt cols=10.obs;
  var hiveBox = Hive.box("secrets");
  Future<String?> getUserId () async {
    if (userId != null) {
      return userId!;
    }
    debugPrint('Getting user id');
    userId = await hiveBox.get("userId");

    return userId;
  }
  Future<String?> getName () async {
    if (name != null) {
      return name!;
    }
    debugPrint('Getting name');
    name = await hiveBox.get("Name");

    return name;
  }
  Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      dobController.text = formattedDate;
    } else {
      dobController.clear();
    }
  }

  appleRegister(
      String email, String password, String imgUrl, String fullName) async {

  }
  @override
  void onInit() async {
    super.onInit();
    userId ??= await getUserId();
    name??=await getName();
    if (userId == null) {
      debugPrint("NO AUTH");
    } else {
      debugPrint("AUTH");
      isAuth.value = true;
    }
  }



}