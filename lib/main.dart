import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkin/constants/colors.dart';
import 'package:parkin/screens/auth/homescreen.dart';
import 'package:parkin/screens/parkin/signup.dart';
import 'package:parkin/screens/parkin/signupin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

import 'controller/jwt_controller.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.openBox('secrets');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer
      (builder: (context, orientation, deviceType)
          {
            return GetMaterialApp(
              theme: ThemeData.light().copyWith(
                textTheme: GoogleFonts.poppinsTextTheme(),
              ),
              debugShowCheckedModeBanner: false,
              home: HomePage(),
            );
          }
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var authController = Get.put(JWTController(), permanent: true);
  @override
  void initState()
  {
    super.initState();
    NavigateFromSplash();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backLightColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'ParkIn',
                style: TextStyle(
                  color:redColor,
                  fontSize: 27,
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Lottie.asset(
                "assets/icons/CarPark.json",
                width: 30.w,
              ),
            ],
          ),
        ),
    );
  }

  void NavigateFromSplash() async{
    await Future.delayed(const Duration(milliseconds: 4000));
    Get.off(()=>Obx(() => !authController.isAuth.value ? CommonAuthScreen() : const HomeScreen()),);
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backLightColor,
      body: Center(
        child: Text(
          'ParkIn',
          style: TextStyle(
            color:redColor,
            fontSize: 27,
          ),
        ),
      ),
    );
  }
}


