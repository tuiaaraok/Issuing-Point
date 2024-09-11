import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:order/data/boxes.dart';
import 'package:order/data/parcels.dart';

class OrderIssuance extends StatefulWidget {
  @override
  State<OrderIssuance> createState() => _OrderIssuanceState();
}

class _OrderIssuanceState extends State<OrderIssuance> {
  List<Widget> nameProduct = [];
  int currentIndex = -1;
  TextEditingController productIdController = TextEditingController();
  bool isOpen = false;
  bool openComplet = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
            valueListenable: Hive.box<Parcels>(HiveBoxes.parcels).listenable(),
            builder: (context, Box<Parcels> box, _) {
              nameProduct.clear();
              for (int i = box.values.length - 1; i >= 0; i--) {
                if (box.getAt(i)!.status == "Expects") {
                  nameProduct.add(
                    GestureDetector(
                      onTap: () {
                        isOpen = false;
                        currentIndex = i;
                        productIdController.text =
                            box.getAt(i)!.productIdController.toString();
                        setState(() {});
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Container(
                          width: 280.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9).withOpacity(0.25),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r)),
                              border: Border.all(
                                  color: Color(0xFF5C1B73), width: 2.w)),
                          child: Center(
                              child: Text(
                            box.getAt(i)!.productNameController.toString(),
                            style: TextStyle(
                                fontSize: 18.sp, color: Color(0xFF50275E)),
                          )),
                        ),
                      ),
                    ),
                  );
                }
              }

              return Container(
                  width: double.infinity,
                  child: SafeArea(
                      child: SingleChildScrollView(
                          child: Container(
                              width: 390.w,
                              child: Column(children: [
                                Container(
                                  width: 360.w,
                                  child: Text(
                                    "Order issuance",
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
                                openComplet
                                    ? GestureDetector(
                                        onTap: () {
                                          currentIndex = -1;
                                          openComplet = false;
                                          productIdController.clear();
                                          setState(() {});
                                        },
                                        child: Container(
                                          width: 330.w,
                                          height: 300.h,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(24.r))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 100.w,
                                                height: 36.h,
                                              ),
                                              Text(
                                                "Complete!",
                                                style: TextStyle(
                                                    fontSize: 24.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                width: 100.w,
                                                height: 36.h,
                                                decoration: BoxDecoration(
                                                    color: Color(0xFF9200AA),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                24.r))),
                                                child: Center(
                                                  child: Text(
                                                    "Menu",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 330.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24.r),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.h),
                                                child: Container(
                                                  width: 280.w,
                                                  child: Text(
                                                    "Product Name",
                                                    style: TextStyle(
                                                        fontSize: 18.sp,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 280.w,
                                                height: 50.h,
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFD9D9D9)
                                                        .withOpacity(0.25),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12.r)),
                                                    border: Border.all(
                                                        color:
                                                            Color(0xFF5C1B73),
                                                        width: 2.w)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: 45.h,
                                                    ),
                                                    currentIndex == -1
                                                        ? Text("")
                                                        : Text(
                                                            box
                                                                .getAt(
                                                                    currentIndex)!
                                                                .productNameController
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 18.sp,
                                                                color: Color(
                                                                    0xFF50275E)),
                                                          ),
                                                    IconButton(
                                                        onPressed: () {
                                                          isOpen = !isOpen;

                                                          setState(() {});
                                                        },
                                                        icon: Icon(
                                                          !isOpen
                                                              ? Icons
                                                                  .keyboard_arrow_down
                                                              : Icons
                                                                  .keyboard_arrow_up,
                                                          size: 30.h,
                                                        ))
                                                  ],
                                                ),
                                              ),
                                              if (isOpen) ...nameProduct,
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.h),
                                                child: Container(
                                                  width: 280.w,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 4.h),
                                                        child: Text(
                                                          "Product Id",
                                                          style: TextStyle(
                                                              fontSize: 18.sp,
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 50.h,
                                                        width: 130.w,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        12.r)),
                                                            color: Color(
                                                                    0xFFD9D9D9)
                                                                .withOpacity(
                                                                    0.25),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFF5C1B73),
                                                                width: 2.w)),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10.w),
                                                          child: TextField(
                                                            textAlign: TextAlign
                                                                .center,
                                                            maxLines: 6,
                                                            controller:
                                                                productIdController,
                                                            decoration:
                                                                InputDecoration(
                                                                    border: InputBorder
                                                                        .none, // Убираем обводку
                                                                    focusedBorder:
                                                                        InputBorder
                                                                            .none, // Убираем обводку при фокусе
                                                                    hintText:
                                                                        '... ...',
                                                                    hintStyle: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            18.sp)),
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            cursorColor: Colors
                                                                .transparent,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    18.sp),
                                                            onChanged: (text) {
                                                              setState(() {});
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.h),
                                                child: Container(
                                                  width: 268.w,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 268.w,
                                                        child: Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                bool isCurrent =
                                                                    false;
                                                                if (productIdController
                                                                        .text !=
                                                                    "") {
                                                                  if (currentIndex ==
                                                                      -1) {
                                                                    int j = -1;
                                                                    for (int i =
                                                                            0;
                                                                        i < box.values.length;
                                                                        i++) {
                                                                      if (box
                                                                              .getAt(i)!
                                                                              .status ==
                                                                          "Expects") {
                                                                        if (box.getAt(i)!.productIdController.toString() ==
                                                                            productIdController.text) {
                                                                          j = i;
                                                                          isCurrent =
                                                                              true;
                                                                        }
                                                                      }
                                                                    }
                                                                    if (isCurrent) {
                                                                      openComplet =
                                                                          true;
                                                                      Box<Parcels>
                                                                          contactsBox =
                                                                          Hive.box<Parcels>(
                                                                              HiveBoxes.parcels);
                                                                      contactsBox
                                                                          .putAt(
                                                                              j,
                                                                              Parcels(
                                                                                status: "Rejection",
                                                                                productNameController: box.getAt(j)!.productNameController,
                                                                                productWeightController: box.getAt(j)!.productWeightController,
                                                                                typeOfGoodsController: box.getAt(j)!.typeOfGoodsController,
                                                                                dateOfReceiptOfgoodsController: box.getAt(j)!.dateOfReceiptOfgoodsController,
                                                                                productIdController: box.getAt(j)!.productIdController,
                                                                              ));
                                                                      setState(
                                                                          () {});
                                                                    }
                                                                  } else {
                                                                    openComplet =
                                                                        true;
                                                                    Box<Parcels>
                                                                        contactsBox =
                                                                        Hive.box<Parcels>(
                                                                            HiveBoxes.parcels);
                                                                    contactsBox.putAt(
                                                                        currentIndex,
                                                                        Parcels(
                                                                          status:
                                                                              "Rejection",
                                                                          productNameController: box
                                                                              .getAt(currentIndex)!
                                                                              .productNameController,
                                                                          productWeightController: box
                                                                              .getAt(currentIndex)!
                                                                              .productWeightController,
                                                                          typeOfGoodsController: box
                                                                              .getAt(currentIndex)!
                                                                              .typeOfGoodsController,
                                                                          dateOfReceiptOfgoodsController: box
                                                                              .getAt(currentIndex)!
                                                                              .dateOfReceiptOfgoodsController,
                                                                          productIdController: box
                                                                              .getAt(currentIndex)!
                                                                              .productIdController,
                                                                        ));
                                                                    setState(
                                                                        () {});
                                                                  }
                                                                }
                                                              },
                                                              child: Container(
                                                                width: 100.w,
                                                                height: 36.h,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              12.r)),
                                                                  color: productIdController
                                                                              .text ==
                                                                          ""
                                                                      ? Color.fromARGB(
                                                                          255,
                                                                          65,
                                                                          1,
                                                                          75)
                                                                      : Color(
                                                                          0xFF9200AA),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    "Rejection",
                                                                    style: TextStyle(
                                                                        color: productIdController.text ==
                                                                                ""
                                                                            ? Colors
                                                                                .grey
                                                                            : Colors
                                                                                .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            16.sp),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            GestureDetector(
                                                              onTap: () {
                                                                bool isCurrent =
                                                                    false;
                                                                if (productIdController
                                                                        .text !=
                                                                    "") {
                                                                  if (currentIndex ==
                                                                      -1) {
                                                                    int j = -1;
                                                                    for (int i =
                                                                            0;
                                                                        i < box.values.length;
                                                                        i++) {
                                                                      if (box
                                                                              .getAt(i)!
                                                                              .status ==
                                                                          "Expects") {
                                                                        if (box.getAt(i)!.productIdController.toString() ==
                                                                            productIdController.text) {
                                                                          j = i;
                                                                          isCurrent =
                                                                              true;
                                                                        }
                                                                      }
                                                                    }
                                                                    if (isCurrent) {
                                                                      openComplet =
                                                                          true;
                                                                      Box<Parcels>
                                                                          contactsBox =
                                                                          Hive.box<Parcels>(
                                                                              HiveBoxes.parcels);
                                                                      contactsBox
                                                                          .putAt(
                                                                              j,
                                                                              Parcels(
                                                                                status: "Issued",
                                                                                productNameController: box.getAt(j)!.productNameController,
                                                                                productWeightController: box.getAt(j)!.productWeightController,
                                                                                typeOfGoodsController: box.getAt(j)!.typeOfGoodsController,
                                                                                dateOfReceiptOfgoodsController: box.getAt(j)!.dateOfReceiptOfgoodsController,
                                                                                productIdController: box.getAt(j)!.productIdController,
                                                                              ));
                                                                      setState(
                                                                          () {});
                                                                    }
                                                                  } else {
                                                                    openComplet =
                                                                        true;
                                                                    Box<Parcels>
                                                                        contactsBox =
                                                                        Hive.box<Parcels>(
                                                                            HiveBoxes.parcels);
                                                                    contactsBox.putAt(
                                                                        currentIndex,
                                                                        Parcels(
                                                                          status:
                                                                              "Issued",
                                                                          productNameController: box
                                                                              .getAt(currentIndex)!
                                                                              .productNameController,
                                                                          productWeightController: box
                                                                              .getAt(currentIndex)!
                                                                              .productWeightController,
                                                                          typeOfGoodsController: box
                                                                              .getAt(currentIndex)!
                                                                              .typeOfGoodsController,
                                                                          dateOfReceiptOfgoodsController: box
                                                                              .getAt(currentIndex)!
                                                                              .dateOfReceiptOfgoodsController,
                                                                          productIdController: box
                                                                              .getAt(currentIndex)!
                                                                              .productIdController,
                                                                        ));
                                                                    setState(
                                                                        () {});
                                                                  }
                                                                }
                                                              },
                                                              child: Container(
                                                                width: 100.w,
                                                                height: 36.h,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(12
                                                                            .r)),
                                                                    color: productIdController.text ==
                                                                            ""
                                                                        ? Color.fromARGB(
                                                                            255,
                                                                            65,
                                                                            1,
                                                                            75)
                                                                        : Color(
                                                                            0xFF9200AA)),
                                                                child: Center(
                                                                  child: Text(
                                                                    "Issue",
                                                                    style: TextStyle(
                                                                        color: productIdController.text ==
                                                                                ""
                                                                            ? Colors
                                                                                .grey
                                                                            : Colors
                                                                                .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            16.sp),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                              ])))));
            }));
  }
}
