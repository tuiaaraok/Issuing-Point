import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';
import 'package:order/data/boxes.dart';
import 'package:order/data/parcels.dart';

class CreateReceivingParcelsPage extends StatefulWidget {
  @override
  State<CreateReceivingParcelsPage> createState() =>
      _CreateReceivingParcelsPageState();
}

class _CreateReceivingParcelsPageState
    extends State<CreateReceivingParcelsPage> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productWeightController = TextEditingController();
  TextEditingController typeOfGoodsController = TextEditingController();
  TextEditingController dateOfReceiptOfgoodsController =
      TextEditingController();
  TextEditingController productIdController = TextEditingController();
  DateTime _currentMonth = DateTime.now();
  DateTime _selectDate = DateTime.now();
  bool isOpenCalendar = false;

  PageController _pageController =
      PageController(initialPage: DateTime.now().month - 1);

  _updateFormCompletion() {
    bool isFilled = productNameController.text.isNotEmpty &&
        productWeightController.text.isNotEmpty &&
        typeOfGoodsController.text.isNotEmpty &&
        dateOfReceiptOfgoodsController.text.isNotEmpty &&
        productIdController.text.isNotEmpty;
    setState(() {});
    return isFilled;
  }

  @override
  void initState() {
    super.initState();
    productNameController.addListener(_updateFormCompletion);
    productWeightController.addListener(_updateFormCompletion);
    typeOfGoodsController.addListener(_updateFormCompletion);
    dateOfReceiptOfgoodsController.addListener(_updateFormCompletion);
    productIdController.addListener(_updateFormCompletion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 75.h,
              ),
              Container(
                width: 360.w,
                child: Text(
                  "Receiving parcels",
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
              !isOpenCalendar
                  ? Column(
                      children: [
                        Container(
                          width: 310.w,
                          child: Text(
                            "Product Name",
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white.withOpacity(0.5),
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Container(
                          height: 55.h,
                          width: 310.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r)),
                              color: Color(0xFFD9D9D9).withOpacity(0.25),
                              border: Border.all(
                                  color: Color(0xFF5C1B73), width: 2.w)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Center(
                              child: TextField(
                                controller: productNameController,
                                decoration: InputDecoration(
                                    border: InputBorder.none, // Убираем обводку
                                    focusedBorder: InputBorder
                                        .none, // Убираем обводку при фокусе
                                    hintText: 'Name',
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 18.sp)),
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.transparent,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp),
                                onChanged: (text) {
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 28.h,
                        ),
                        Container(
                          width: 310.w,
                          child: Text(
                            "Product weight",
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white.withOpacity(0.5),
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Container(
                          height: 55.h,
                          width: 310.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r)),
                              color: Color(0xFFD9D9D9).withOpacity(0.25),
                              border: Border.all(
                                  color: Color(0xFF5C1B73), width: 2.w)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Center(
                              child: TextField(
                                controller: productWeightController,
                                decoration: InputDecoration(
                                    border: InputBorder.none, // Убираем обводку
                                    focusedBorder: InputBorder
                                        .none, // Убираем обводку при фокусе
                                    hintText: 'kg',
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 18.sp)),
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.transparent,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp),
                                onChanged: (text) {
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 28.h,
                        ),
                        Container(
                          width: 310.w,
                          child: Text(
                            "Type of goods",
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white.withOpacity(0.5),
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Container(
                          height: 55.h,
                          width: 310.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r)),
                              color: Color(0xFFD9D9D9).withOpacity(0.25),
                              border: Border.all(
                                  color: Color(0xFF5C1B73), width: 2.w)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Center(
                              child: TextField(
                                controller: typeOfGoodsController,
                                decoration: InputDecoration(
                                    border: InputBorder.none, // Убираем обводку
                                    focusedBorder: InputBorder
                                        .none, // Убираем обводку при фокусе
                                    hintText: 'Type',
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 18.sp)),
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.transparent,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp),
                                onChanged: (text) {
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 28.h,
                        ),
                        Container(
                          width: 310.w,
                          child: Text(
                            "Date of receipt of goods",
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                      ],
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 10.h),
                      child: Container(
                        height: 360.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r))),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Container(
                                  height: 20.sp,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (_currentMonth.month == 1) {
                                            // Если января — переключаемся на декабрь предыдущего года
                                            setState(() {
                                              _currentMonth = DateTime(
                                                  _currentMonth.year - 1, 12);
                                              _pageController.jumpToPage(
                                                  11); // Сброс к странице 11 (декабрь предыдущего года)
                                            });
                                          } else {
                                            setState(() {
                                              _currentMonth = DateTime(
                                                _currentMonth.year,
                                                _currentMonth.month - 1,
                                              );
                                              _pageController.previousPage(
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                curve: Curves.easeInOut,
                                              );
                                            });
                                          }
                                        },
                                        child: SvgPicture.asset(
                                          "assets/arrow_back.svg",
                                          width: 38.w,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Text(
                                        DateFormat('MMMM')
                                            .format(_currentMonth),
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (_currentMonth.month == 12) {
                                            // Если декабря — переключаемся на январь следующего года
                                            setState(() {
                                              _currentMonth = DateTime(
                                                  _currentMonth.year + 1, 1);
                                              _pageController.jumpToPage(
                                                  0); // Сброс к странице 0 (январь следующего года)
                                            });
                                          } else {
                                            setState(() {
                                              _currentMonth = DateTime(
                                                _currentMonth.year,
                                                _currentMonth.month + 1,
                                              );
                                              _pageController.nextPage(
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                curve: Curves.easeInOut,
                                              );
                                            });
                                          }
                                        },
                                        child: SvgPicture.asset(
                                          "assets/arrow_next.svg",
                                          width: 38.w,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 270.h,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 40.w),
                                  child: PageView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    controller: _pageController,
                                    onPageChanged: (index) {
                                      setState(() {
                                        _currentMonth = DateTime(
                                          _currentMonth.year,
                                          index + 1,
                                        );
                                      });
                                    },
                                    itemCount: 12 * 3,
                                    itemBuilder: (context, pageIndex) {
                                      return buildCalendar(
                                        DateTime(_currentMonth.year,
                                            pageIndex + 1, 1),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              Padding(
                padding: EdgeInsets.only(left: 45.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Container(
                        height: 50.h,
                        width: 130.w,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r)),
                            color: Color(0xFFD9D9D9).withOpacity(0.25),
                            border: Border.all(
                                color: Color(0xFF5C1B73), width: 2.w)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: TextField(
                            maxLines: 6,
                            controller: dateOfReceiptOfgoodsController,
                            decoration: InputDecoration(
                                border: InputBorder.none, // Убираем обводку
                                focusedBorder: InputBorder
                                    .none, // Убираем обводку при фокусе
                                hintText: '12/12/2024',
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 18.sp)),
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.transparent,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp),
                            onChanged: (text) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            isOpenCalendar = !isOpenCalendar;
                            setState(() {});
                          },
                          icon: Icon(
                            isOpenCalendar
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: isOpenCalendar
                                ? Colors.white
                                : Color(0xFF50275E),
                            size: 40.h,
                          ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 28.h,
              ),
              Container(
                width: 310.w,
                child: Text(
                  "Product Id",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 45.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 50.h,
                    width: 130.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12.r)),
                        color: Color(0xFFD9D9D9).withOpacity(0.25),
                        border:
                            Border.all(color: Color(0xFF5C1B73), width: 2.w)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: TextField(
                        textAlign: TextAlign.center,
                        maxLines: 6,
                        controller: productIdController,
                        decoration: InputDecoration(
                            border: InputBorder.none, // Убираем обводку
                            focusedBorder:
                                InputBorder.none, // Убираем обводку при фокусе
                            hintText: '... ...',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 18.sp)),
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.transparent,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp),
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: GestureDetector(
                  onTap: () {
                    if (_updateFormCompletion()) {
                      Box<Parcels> contactsBox =
                          Hive.box<Parcels>(HiveBoxes.parcels);
                      contactsBox.add(Parcels(
                        status: "Expects",
                        productNameController: productNameController.text,
                        productWeightController: productWeightController.text,
                        typeOfGoodsController: typeOfGoodsController.text,
                        dateOfReceiptOfgoodsController:
                            dateOfReceiptOfgoodsController.text,
                        productIdController: productIdController.text,
                      ));
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    width: 180.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        color: _updateFormCompletion()
                            ? Colors.white
                            : Color.fromARGB(255, 109, 109, 109),
                        borderRadius: BorderRadius.all(Radius.circular(12.r))),
                    child: Center(
                      child: Text(
                        "Create",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCalendar(DateTime month) {
    int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    DateTime firstDayOfMonth = DateTime(month.year, month.month, 1);
    int weekdayOfFirstDay = firstDayOfMonth.weekday;

    List<Widget> calendarCells = [];

    // Добавляем названия дней недели
    List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    for (String day in weekDays) {
      calendarCells.add(
        Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Container(
            decoration: const BoxDecoration(border: Border()),
            alignment: Alignment.center,
            child:
                Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      );
    }

    // Добавляем дни предыдущего месяца
    int daysInPreviousMonth = DateTime(month.year, month.month, 0).day;
    int daysToShowFromPreviousMonth = (weekdayOfFirstDay - 1) % 7;

    for (int i = daysInPreviousMonth - daysToShowFromPreviousMonth + 1;
        i <= daysInPreviousMonth;
        i++) {
      DateTime date = DateTime(month.year, month.month - 1, i);
      calendarCells.add(
        GestureDetector(
          onTap: () {
            // Здесь можно добавить логику для выбора даты
          },
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                border: Border(),
              ),
              child: Center(
                child: Text(date.day.toString(),
                    style: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
      );
    }

    // Добавляем дни текущего месяца
    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(month.year, month.month, i);
      calendarCells.add(
        GestureDetector(
          onTap: () {
            _selectDate = date;
            dateOfReceiptOfgoodsController.text =
                DateFormat("d/M/y").format(date);
            setState(() {});
          },
          child: Container(
              decoration: BoxDecoration(
                color: DateFormat("DD MM YY").format(date) ==
                        DateFormat("DD MM YY").format(_selectDate)
                    ? Color(0xFFFF0000).withOpacity(0.8)
                    : Colors.white, // Цвет для дней текущего месяца
                borderRadius: BorderRadius.all(Radius.circular(50)),
                border: Border(),
              ),
              child: Center(
                child: Text(date.day.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              )),
        ),
      );
    }
    print(calendarCells.length);
    print((calendarCells.length / 7).toInt() + 1);

    int size = calendarCells.length;
    print((7 * ((size / 7).toInt() + 1)).toString());
    print((size - (7 * ((size / 7).toInt() + 1))).toString());
    // Добавляем дни текущего месяца
    for (int i = 1;
        size % 7 != 0 ? i <= (7 * ((size / 7).toInt() + 1)) - size : false;
        i++) {
      DateTime date = DateTime(month.year, month.month + 1, i);
      calendarCells.add(
        GestureDetector(
          onTap: () {
            // Здесь можно добавить логику для выбора даты
          },
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                border: Border(),
              ),
              child: Center(
                child: Text(date.day.toString(),
                    style: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
      );
    }

    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      crossAxisCount: 7,
      childAspectRatio: 1,
      children: calendarCells,
    );
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}
