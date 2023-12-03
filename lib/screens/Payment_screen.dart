import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkin/constants/colors.dart';
import 'package:parkin/controller/jwt_controller.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final double baseFare = 30.0;
  final double hourlyRate = 10.0;
  var _razorpay = Razorpay();

  final jwt= Get.put(JWTController(),permanent: true);
  @override
  Widget build(BuildContext context) {
    
    double hoursDifference = DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(jwt.firstTimeTap.value)).inHours.toDouble();
    double totalFare = baseFare + (hoursDifference * hourlyRate);
    var options = {
      'key': '<YOUR_KEY_HERE>',
      'amount': totalFare.toString(),
      'name': 'ParkIn',
      'description': 'Parking Fare',
      'prefill': {
        'contact': '9911433169',
        'email': 'test@razorpay.com'
      }
    };
    return Scaffold(
      backgroundColor: backLightColor,
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Booked Seats: ${jwt.bookedSeat}',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 10.0),
          Text(
            'Base Fare: ₹${baseFare.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 10.0),
          Text(
            'Hourly Rate: ₹${hourlyRate.toStringAsFixed(2)} per hour',
            style: TextStyle(fontSize: 18.0),
          ),
          Text(
            'Total Hours: ${hoursDifference.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18.0),
          ),
          Text(
            'Total Fare',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Text(
            '₹${totalFare.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 24.0, color: redColor, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              _razorpay.open(options);
            },
            child: Text('Proceed to Payment'),
          ),
        ],
      ),
    );
  }
}
