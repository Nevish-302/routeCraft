// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:ai_travel_planner/features/travel/screen/itenary/whoPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:velocity_x/velocity_x.dart';

import 'booking.dart';

List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

class Scheduler extends StatefulWidget {
  String title;

  Scheduler({
    super.key,
    this.title = "some",
  });

  @override
  State<Scheduler> createState() => _SchedulerState();
}

class _SchedulerState extends State<Scheduler> {
  var time = 0;

  DateTime rangeStart = DateTime.now();
  DateTime rangeEnd = DateTime.now();
  String when = "When";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "asset/sky1.jpg",
              fit: BoxFit.fill,
            )),
        Padding(
          padding:
              const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Title
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    widget.title,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                  ),
                ),

                ///categs
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.24,
                          height: MediaQuery.of(context).size.width * 0.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color.fromARGB(255, 158, 197, 229)
                                  .withOpacity(0.3),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.3))),
                          child: "${when}"
                              .text
                              .color(Colors.white.withOpacity(0.8))
                              .makeCentered(),
                        ).p(10),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.width * 0.1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.transparent,
                          border:
                              Border.all(color: Colors.white.withOpacity(0.3))),
                      child: "WHO"
                          .text
                          .color(Colors.white.withOpacity(0.5))
                          .makeCentered(),
                    ).p(10),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      height: MediaQuery.of(context).size.width * 0.1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.transparent,
                          border:
                              Border.all(color: Colors.white.withOpacity(0.3))),
                      child: "Where"
                          .text
                          .color(Colors.white.withOpacity(0.5))
                          .makeCentered(),
                    ).p(10),
                  ],
                ),

                ///step
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Step 1 : ",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 25,
                              color: Colors.white.withOpacity(0.4))),
                    ),
                    Text(
                      "Choose the dates for\nthe trip :",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 25,
                              color: Colors.white.withOpacity(0.4))),
                    ),
                  ],
                ),

                ///start and departure
                Row(
                  children: [
                    Column(
                      children: [
                        "Start"
                            .text
                            .minFontSize(20)
                            .color(Colors.white.withOpacity(0.5))
                            .makeCentered()
                            .p(5),
                        "${rangeStart.day.toString() + " " + months[rangeStart.month]}"
                            .text
                            .white
                            .make(),
                      ],
                    ).pLTRB(0, 0, 40, 0),
                    Column(
                      children: [
                        "Departure"
                            .text
                            .minFontSize(20)
                            .color(Colors.white.withOpacity(0.5))
                            .makeCentered()
                            .p(5),
                        "${rangeEnd.day.toString() + " " + months[rangeStart.month]}"
                            .text
                            .white
                            .make(),
                      ],
                    ),
                  ],
                ).pLTRB(100, 0, 0, 0),

                ///Calendar
                ClipRRect(
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        // gradient: LinearGradient(colors: [const Color.fromARGB(255, 125, 166, 237).withOpacity(0.2),const Color.fromARGB(255, 82, 129, 169).withOpacity(0.2)]),
                        borderRadius: BorderRadius.circular(20)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                      child: TableCalendar(
                        // headerVisible: false,

                        calendarFormat: CalendarFormat.month,
                        rangeSelectionMode: RangeSelectionMode.enforced,

                        //
                        rangeStartDay: rangeStart,
                        rangeEndDay: rangeEnd,
                        //
                        //  onDayLongPressed: ,
                        onDaySelected: (selectedDay, focusedDay) {
                          rangeStart = selectedDay;
                          setState(() {});
                        },
                        onDayLongPressed: (selectedDay, focusedDay) {
                          rangeEnd = selectedDay;
                          when = rangeStart.day.toString() +
                              "-" +
                              rangeEnd.day.toString() +
                              " " +
                              months[rangeStart.month - 1];
                          setState(() {});
                        },

                        headerStyle: HeaderStyle(
                            titleCentered: true,
                            titleTextStyle:
                                TextStyle(color: Colors.white, fontSize: 24)),
                        daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: TextStyle(color: Colors.white),
                            weekendStyle: TextStyle(color: Colors.white)),

                        calendarStyle: CalendarStyle(
                          rangeHighlightColor: Colors.white.withOpacity(0.2),
                          withinRangeTextStyle: TextStyle(color: Colors.white),
                          rangeStartDecoration: BoxDecoration(
                              // border: Border.all(),
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100)),
                          rangeEndDecoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100)),
                          // tableBorder: TableBorder(borderRadius: BorderRadius.circular(20),)
                        ),

                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2050, 3, 14),
                        focusedDay: DateTime.now(),
                      ),
                    ),
                  ).p(10),
                ).pLTRB(0, MediaQuery.of(context).size.height * 0.075, 0, 0),
                SizedBox(
                  height: 50,
                ),
                // Center(
                //   child: ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: Colors.blue,
                //         shape: CircleBorder(),
                //       ),
                //       onPressed: () {
                //         Get.to(Book(text: widget.title));
                //       },
                //       child: Padding(
                //         padding: const EdgeInsets.all(12.0),
                //         child: Icon(
                //           Iconsax.arrow_right4,
                //           color: Colors.white,
                //         ),
                //       )),
                // )
              ],
            ),
          ),
        ),
      ]),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: CircleBorder(),
            ),
            onPressed: () {
              Get.to(WhoScreen(
                title: widget.title,
                when:
                    "${rangeEnd.day.toString() + " " + months[rangeStart.month]}",
                days: rangeEnd.day - rangeStart.day + 1,
              ));
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Iconsax.arrow_right4,
                color: Colors.white,
              ),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
