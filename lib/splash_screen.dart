import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const HomePage(),
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
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            height: 256.h,
            width: 256.w,
            decoration: const BoxDecoration(
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
