import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order/home_page.dart';
import 'package:order/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Задержка в 5 секунд, после которой происходит навигация на новый экран
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => HomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "Welcome to our app...",
              style: TextStyle(
                  fontSize: 24.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        leadingWidth: double.infinity,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            height: 256.h,
            width: 256.w,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/welcome.png",
                    ),
                    fit: BoxFit.fill)),
          ),
          Text(
            "Enjoy your use!",
            style: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          )
        ]),
      ),
    );
  }
}
