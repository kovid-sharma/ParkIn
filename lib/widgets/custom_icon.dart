import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class CustomIcon extends StatelessWidget {
  bool? repeat;
  CustomIcon({
    Key? key,
    this.repeat,
  }) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.asset('assets/icons/CarPark.json',
        repeat: repeat??false
      ),
    );
  }
}