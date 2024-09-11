import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';
import 'package:order/create_receiving_parcels_page.dart';
import 'package:order/data/boxes.dart';
import 'package:order/data/parcels.dart';
import 'package:order/home_page.dart';
import 'package:order/info_page.dart';
import 'package:order/onboarding_page.dart';
import 'package:order/order_issuance.dart';
import 'package:order/parcel_list_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:order/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ParcelsAdapter());
  // Hive.registerAdapter(DayIsAdapter());
  await Hive.openBox<Parcels>(HiveBoxes.parcels);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(400, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              // onGenerateRoute: NavigationApp.generateRoute,
              theme: ThemeData(
                  scaffoldBackgroundColor: Color(0xFF9200AA),
                  appBarTheme:
                      AppBarTheme(backgroundColor: Colors.transparent)),
              home: Hive.box<Parcels>(HiveBoxes.parcels).isEmpty
                  ? OnboardingScreen()
                  : HomePage());
        });
  }
}
