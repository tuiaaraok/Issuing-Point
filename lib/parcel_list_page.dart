import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:order/data/boxes.dart';
import 'package:order/data/parcels.dart';

class ParcelListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ParcelListPageState();
}

class _ParcelListPageState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Parcels>(HiveBoxes.parcels).listenable(),
          builder: (context, Box<Parcels> box, _) {
            return Container(
              width: double.infinity,
              child: SafeArea(
                  child: SingleChildScrollView(
                child: Container(
                  width: 390.w,
                  child: Column(
                    children: [
                      Container(
                        width: 360.w,
                        child: Text(
                          "Parcel list",
                          style: TextStyle(
                              fontSize: 24.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 360.w,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  size: 16.sp,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Back",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      for (int i = box.values.length - 1; i >= 0; i--) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Container(
                            width: 300.w,
                            height: 230.h,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r)),
                              color:
                                  box.getAt(i)!.status.toString() == "Expects"
                                      ? Color(0xFFC6B200)
                                      : box.getAt(i)!.status.toString() ==
                                              "Rejection"
                                          ? Color(0xFFA21B1B)
                                          : Color(0xFF31840A),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    box
                                        .getAt(i)!
                                        .productNameController
                                        .toString(),
                                    style: TextStyle(
                                        color: Color(0xFFDC08FF),
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 20.h),
                                    child: SizedBox(
                                      width: 244.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: 136.h,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  box
                                                      .getAt(i)!
                                                      .productWeightController
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  box
                                                      .getAt(i)!
                                                      .typeOfGoodsController
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  box
                                                      .getAt(i)!
                                                      .dateOfReceiptOfgoodsController
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 144.h,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Spacer(),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Status",
                                                      style: TextStyle(
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.5)),
                                                    ),
                                                    SizedBox(
                                                      height: 7.h,
                                                    ),
                                                    Container(
                                                      width: 100.w,
                                                      height: 36.h,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      12.r))),
                                                      child: Center(
                                                        child: Text(
                                                          box
                                                              .getAt(i)!
                                                              .status
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 7.h,
                                                    ),
                                                    Text(
                                                      "id",
                                                      style: TextStyle(
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.5)),
                                                    ),
                                                    SizedBox(
                                                      height: 7.h,
                                                    ),
                                                    Container(
                                                      width: 100.w,
                                                      height: 36.h,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      12.r))),
                                                      child: Center(
                                                        child: Text(
                                                          box
                                                              .getAt(i)!
                                                              .productIdController
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ]
                    ],
                  ),
                ),
              )),
            );
          }),
    );
  }
}
