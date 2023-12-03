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
    authController.getName();
    authController.getUserId();
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



class Seat {
  final int row;
  final int number;
  bool isReserved;

  Seat(this.row, this.number, this.isReserved);
}

class MyGrid extends StatefulWidget {
  @override
  _MyGridState createState() => _MyGridState();
}

class _MyGridState extends State<MyGrid> {
  // Replace this with your actual seat data
  final List<List<Seat>> seats = [
    [Seat(1, 1, false), Seat(1, 2, false), Seat(1, 3, true)],
    [Seat(2, 1, false), Seat(2, 2, false), Seat(2, 3, false)],
    [Seat(3, 1, false), Seat(3, 2, false), Seat(3, 3, true)],
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: seats[0].length,
        childAspectRatio: 1.0, // Aspect ratio for square blocks
      ),
      itemCount: seats.length * seats[0].length,
      itemBuilder: (BuildContext context, int index) {
        int row = index ~/ seats[0].length;
        int col = index % seats[0].length;
        Seat seat = seats[row][col];

        return GestureDetector(
          onTap: () {
            // Add your seat selection logic here
            if (!seat.isReserved) {
              setState(() {
                seat.isReserved = !seat.isReserved;
              });
            }
          },
          child: Container(
            margin: EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: seat.isReserved ? Colors.grey : Colors.green,
              border: Border.all(),
            ),
            child: Center(
              child: Text(
                '${seat.row}-${seat.number}',
                style: TextStyle(
                  color: seat.isReserved ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}



