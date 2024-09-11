import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';
import 'package:order/create_receiving_parcels_page.dart';
import 'package:order/data/boxes.dart';
import 'package:order/data/parcels.dart';
import 'package:order/info_page.dart';
import 'package:order/order_issuance.dart';
import 'package:order/parcel_list_page.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  List<Widget> calendarCells = List<Widget>.generate(180, (index) {
    // Вычисляем номер текущего столбца, используя индекс
    int column =
        (index ~/ 9) % 20; // Определяем номер столбца каждую 7-й элемент
    double opacity =
        0.5 - (column * 0.03).clamp(0.0, 0.5); // Уменьшаем непрозрачность

    return Opacity(
      opacity: opacity,
      child: Container(
        child: Icon(
          IconsaxPlusLinear.box,
          color: Colors.black,
          size: 30.w,
        ),
      ),
    );
  });
  DateTime now = DateTime.now();
  DateTime? closestDate;
  int numberOfParcelsIssued = 0;
  int numberOfRejections = 0;
  int pending = 0;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<Parcels>(HiveBoxes.parcels).listenable(),
        builder: (context, Box<Parcels> box, _) {
          numberOfParcelsIssued = 0;
          numberOfRejections = 0;
          pending = 0;
          for (int i = 0; i < box.values.length; i++) {
            if (box.getAt(i)!.status == "Expects") {
              // Разбираем строку даты
              List<String> parts =
                  box.getAt(i)!.dateOfReceiptOfgoodsController!.split('/');
              DateTime parsedDate = DateTime(int.parse(parts[2]),
                  int.parse(parts[1]), int.parse(parts[0]));

              // Сравниваем с текущей датой
              if (closestDate == null ||
                  (parsedDate.isAfter(now) &&
                      parsedDate.isBefore(closestDate!))) {
                closestDate = parsedDate;
              }

              // Выводим ближайшую дату
              if (closestDate != null) {
                print(
                    'Ближайшая дата: ${DateFormat('dd.MM.yyyy').format(closestDate!)}');
              } else {
                print('Нет будущих дат.');
              }

              pending += 1;
            }
            if (box.getAt(i)!.status == "Rejection") {
              numberOfRejections += 1;
            }
            if (box.getAt(i)!.status == "Issued") {
              numberOfParcelsIssued += 1;
            }
          }
          return Scaffold(
            body: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    crossAxisCount: 9,
                    children: calendarCells,
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 40.w, top: 70.h),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => InfoPage(),
                              ),
                            );
                          },
                          child: Container(
                            width: 180.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.r))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  IconsaxPlusLinear.clipboard_import,
                                  color: Color(0xFF9200AA),
                                  size: 24.w,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                  child: Text(
                                    "Feedback",
                                    style: TextStyle(
                                        color: Color(0xFF9200AA),
                                        fontSize: 18.sp),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    pending == 0
                        ? Container(
                            width: 360.w,
                            height: 300.h,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 300.h,
                                    height: 300.h,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage("assets/empty.png"),
                                            fit: BoxFit.fill)),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20.h,
                                  left: 170.h,
                                  child: Container(
                                    width: 150.w,
                                    height: 60.h,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.r))),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Text(
                                            "You have no\norders",
                                            style: TextStyle(
                                                color: Color(0xFF9200AA),
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold,
                                                height: 1.h),
                                          ),
                                        ),
                                        Positioned(
                                            right: 6.h,
                                            bottom: 8.h,
                                            child: RotatedBox(
                                                quarterTurns: 1,
                                                child: Text(
                                                  "=(",
                                                  style: TextStyle(
                                                      fontSize: 18.sp,
                                                      color: Color(0xFF9200AA)
                                                          .withOpacity(0.5),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )))
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : closestDate != null
                            ? Container(
                                width: 360.w,
                                height: 300.h,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      bottom: 20.h,
                                      child: Container(
                                        width: 250.h,
                                        height: 250.h,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/order.png"),
                                                fit: BoxFit.fill)),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20.h,
                                      left: 180.h,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12.r))),
                                          child: Padding(
                                            padding: EdgeInsets.all(4.0.h),
                                            child: Text(
                                              DateFormat('dd.MM.yyyy')
                                                  .format(closestDate!),
                                              style: TextStyle(
                                                  fontSize: 21.sp,
                                                  color: Color(0xFF9200AA),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                width: 360.w,
                                height: 300.h,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: 300.h,
                                        height: 300.h,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/empty.png"),
                                                fit: BoxFit.fill)),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20.h,
                                      left: 170.h,
                                      child: Container(
                                        width: 150.w,
                                        height: 60.h,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.r))),
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Text(
                                                "You have no\norders",
                                                style: TextStyle(
                                                    color: Color(0xFF9200AA),
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    height: 1.h),
                                              ),
                                            ),
                                            Positioned(
                                                right: 6.h,
                                                bottom: 8.h,
                                                child: RotatedBox(
                                                    quarterTurns: 1,
                                                    child: Text(
                                                      "=(",
                                                      style: TextStyle(
                                                          fontSize: 18.sp,
                                                          color: Color(
                                                                  0xFF9200AA)
                                                              .withOpacity(0.5),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        CreateReceivingParcelsPage(),
                                  ),
                                );
                              },
                              child: Container(
                                width: 300.w,
                                height: 60.h,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.r))),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        IconsaxPlusLinear.box_tick,
                                        color: Color(0xFF9200AA),
                                        size: 30.h,
                                      ),
                                      Text(
                                        "Receiving parcels",
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 40.w,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        OrderIssuance(),
                                  ),
                                );
                              },
                              child: Container(
                                width: 300.w,
                                height: 60.h,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.r))),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        IconsaxPlusLinear.convert_3d_cube,
                                        color: Color(0xFF9200AA),
                                        size: 30.h,
                                      ),
                                      Text(
                                        "Order issuance",
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 40.w,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        ParcelListPage(),
                                  ),
                                );
                              },
                              child: Container(
                                width: 300.w,
                                height: 60.h,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.r))),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        IconsaxPlusLinear.clipboard_text,
                                        color: Color(0xFF9200AA),
                                        size: 30.h,
                                      ),
                                      Text(
                                        "Parcel list",
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 40.w,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Container(
                        width: 360.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.h),
                              child: Text(
                                "Number of parcels : ${box.length}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.h),
                              child: Text(
                                "Number of parcels issued : ${numberOfParcelsIssued}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.h),
                              child: Text(
                                "Number of rejections : ${numberOfRejections}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.h),
                              child: Text(
                                "Pending : ${pending}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }
}
