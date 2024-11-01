import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order/splash_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 2;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      height: isActive ? 12.0.h : 14.h,
      width: isActive ? 50.w : 14.h,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.black.withOpacity(0.5),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 630.h,
                child: PageView(
                  physics: const ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: const <Widget>[
                    FirstWidgetForOnBoardingInfo(
                      assetImage: 'assets/onboarding_first.png',
                      title: 'Picking up orders just\ngot a lot easier! ',
                      subtitle: 'Add and follow the',
                      subtitle_1: ' Status ',
                      subtitle_2:
                          ' of\nthe parcel, also track the total\nnumber of all ',
                      subtitle_3: 'Parcels',
                    ),
                    WidgetForOnBoardingInfo(
                      assetImage: 'assets/onboarding_second.png',
                      title: 'Characterize the parcel\nin detail!',
                      subtitle: "Keep track of your total",
                      subtitle_1: " Order ",
                      subtitle_2:
                          "stats,\ndon't keep them in your head, just\nwrite them ",
                      subtitle_3: 'Down in the app',
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.h),
                    child: GestureDetector(
                      onTap: () async {
                        final Uri url = Uri.parse(
                            'https://docs.google.com/document/d/1VNyCXPAk3TN0fYToZzR01THX91lq-VTApFDHEfl2v3I/mobilebasic');
                        if (!await launchUrl(url)) {
                          throw Exception('Could not launch $url');
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Terms of use",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.sp),
                            child: Container(
                              width: 1,
                              height: 12.sp,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Privacy Policy",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 280.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: _buildPageIndicator(),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_currentPage == 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const SplashScreen(),
                                ),
                              );
                            }
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          child: Container(
                            width: 140.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.r))),
                            child: Center(
                              child: Text(
                                'Next',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WidgetForOnBoardingInfo extends StatelessWidget {
  final String title;

  final String subtitle;
  final String subtitle_1;
  final String subtitle_2;
  final String subtitle_3;
  final String assetImage;

  const WidgetForOnBoardingInfo(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.subtitle_1,
      required this.subtitle_2,
      required this.subtitle_3,
      required this.assetImage});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, bottom: 40.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage(
              assetImage,
            ),
            fit: BoxFit.fitWidth,
            height: 400.h,
            width: 400.h,
          ),
          SizedBox(
            width: 340.w,
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: kTitleStyle,
            ),
          ),
          SizedBox(height: 15.h),
          SizedBox(
            width: 340.w,
            child: RichText(
                text: TextSpan(
              text: subtitle,
              style: kSubtitleStyle,
              children: <TextSpan>[
                TextSpan(
                  text: subtitle_1,
                  style: kSubtitleStyle1,
                ),
                TextSpan(
                  text: subtitle_2,
                  style: kSubtitleStyle,
                ),
                TextSpan(
                  text: subtitle_3,
                  style: kSubtitleStyle1,
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}

final kTitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 24.sp,
);

final kSubtitleStyle = TextStyle(
  color: Colors.white.withOpacity(0.5),
  fontSize: 18.sp,
);
final kSubtitleStyle1 = TextStyle(
  color: Colors.white,
  fontSize: 18.sp,
);

class FirstWidgetForOnBoardingInfo extends StatelessWidget {
  final String title;

  final String subtitle;
  final String subtitle_1;
  final String subtitle_2;
  final String subtitle_3;
  final String assetImage;

  const FirstWidgetForOnBoardingInfo(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.subtitle_1,
      required this.subtitle_2,
      required this.subtitle_3,
      required this.assetImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, bottom: 40.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage(
              assetImage,
            ),
            fit: BoxFit.fitWidth,
            height: 280.h,
            width: 280.h,
          ),
          SizedBox(height: 125.h),
          SizedBox(
            width: 340.w,
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: kTitleStyle,
            ),
          ),
          SizedBox(height: 15.h),
          SizedBox(
            width: 340.w,
            child: RichText(
                text: TextSpan(
              text: subtitle,
              style: kSubtitleStyle,
              children: <TextSpan>[
                TextSpan(
                  text: subtitle_1,
                  style: kSubtitleStyle1,
                ),
                TextSpan(
                  text: subtitle_2,
                  style: kSubtitleStyle,
                ),
                TextSpan(
                  text: subtitle_3,
                  style: kSubtitleStyle1,
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
