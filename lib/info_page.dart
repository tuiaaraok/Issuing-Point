import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 40.w),
          child: Row(children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                radius: 30.r,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.arrow_back,
                  size: 30.w,
                  color: Color(0xFF9200AA),
                ),
              ),
            )
          ]),
        ),
        leadingWidth: 200.w,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 40.w),
            child: Container(
              width: 180.w,
              height: 40.h,
              decoration: BoxDecoration(
                  color: Color(0xFF50275E),
                  borderRadius: BorderRadius.all(Radius.circular(12.r))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    IconsaxPlusLinear.clipboard_import,
                    color: Colors.white,
                    size: 24.w,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      "Feedback",
                      style: TextStyle(color: Colors.white, fontSize: 18.sp),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Container(
                  width: 300.h,
                  height: 300.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/Info_page.png"))),
                )),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        String? encodeQueryParameters(
                            Map<String, String> params) {
                          return params.entries
                              .map((MapEntry<String, String> e) =>
                                  '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                              .join('&');
                        }

                        // ···
                        final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: 'TravisJohnson9902@outlook.com',
                          query: encodeQueryParameters(<String, String>{
                            '': '',
                          }),
                        );
                        try {
                          if (await canLaunchUrl(emailLaunchUri)) {
                            await launchUrl(emailLaunchUri);
                          } else {
                            throw Exception("Could not launch $emailLaunchUri");
                          }
                        } catch (e) {
                          print(
                              'Error launching email client: $e'); // Log the error
                        }
                      },
                      child: Container(
                        width: 320.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                            color: Color(0xFF50275E),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Icon(
                              IconsaxPlusLinear.book,
                              size: 32.h,
                              color: Colors.white,
                            ),
                            SizedBox(
                                width:
                                    8), // Добавьте немного пространства между иконкой и текстом
                            Expanded(
                              child: Text(
                                "Contact us",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.sp),
                                textAlign: TextAlign.center, // Центрируем текст
                              ),
                            ),
                            CircleAvatar(
                              radius: 20.r,
                              backgroundColor: Color(0xFF9200AA),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 21.h,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        final Uri _url = Uri.parse('https://flutter.dev');
                        if (!await launchUrl(_url)) {
                          throw Exception('Could not launch $_url');
                        }
                      },
                      child: Container(
                        width: 320.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                            color: Color(0xFF50275E),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Icon(
                              IconsaxPlusLinear.key_square,
                              size: 32.h,
                              color: Colors.white,
                            ),
                            SizedBox(
                                width:
                                    8), // Добавьте немного пространства между иконкой и текстом
                            Expanded(
                              child: Text(
                                "Privacy policy",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.sp),
                                textAlign: TextAlign.center, // Центрируем текст
                              ),
                            ),
                            CircleAvatar(
                              radius: 20.r,
                              backgroundColor: Color(0xFF9200AA),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 21.h,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        LaunchReview.launch(
                            androidAppId: "app.openauthenticator",
                            iOSAppId: "585027354");
                      },
                      child: Container(
                        width: 320.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                            color: Color(0xFF50275E),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Icon(
                              IconsaxPlusLinear.security_user,
                              size: 32.h,
                              color: Colors.white,
                            ),
                            SizedBox(
                                width:
                                    8), // Добавьте немного пространства между иконкой и текстом
                            Expanded(
                              child: Text(
                                "Rate us",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.sp),
                                textAlign: TextAlign.center, // Центрируем текст
                              ),
                            ),
                            CircleAvatar(
                              radius: 20.r,
                              backgroundColor: Color(0xFF9200AA),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 21.h,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
