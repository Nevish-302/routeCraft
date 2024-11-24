import 'package:ai_travel_planner/features/travel/screen/final/finalScreen.dart';
import 'package:ai_travel_planner/features/travel/screen/itenary/groq.dart';
import 'package:ai_travel_planner/features/travel/screen/reel/reel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';
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
import 'controller/controller.dart';

class WhoScreen extends StatefulWidget {
  const WhoScreen(
      {super.key, required this.title, required this.when, required this.days});
  final String title, when;
  final int days;

  @override
  State<WhoScreen> createState() => _WhoScreenState();
}

class _WhoScreenState extends State<WhoScreen> {
  final Schedule update = Get.put(Schedule());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "asset/sky1.jpg",
              fit: BoxFit.fill,
            )),
        SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
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
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.3))),
                          child: "${widget.when}"
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
                          color: Color.fromARGB(255, 158, 197, 229)
                              .withOpacity(0.3),
                          borderRadius: BorderRadius.circular(15),
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
                      "Step 2 : ",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 25,
                              color: Colors.white.withOpacity(0.4))),
                    ),
                    Text(
                      "Choose with whom \nyou will go :",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 25,
                              color: Colors.white.withOpacity(0.4))),
                    ),
                  ],
                ),

                ///Contact
                Center(
                  child: Column(
                    children: [
                      Container(
                          height: 180,
                          width: MediaQuery.of(context).size.width * 0.5,
                          color: Colors.transparent,
                          child: GridView.builder(
                              itemCount: 6,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4),
                              itemBuilder: (BuildContext, x) {
                                return Container(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(1000)),
                                    child: Image.asset(
                                      "asset/image.jpg",
                                      scale: 0.1,
                                      fit: BoxFit.cover,
                                    )).pLTRB(0, 0, 10, 10);
                              })),
                      "Add contact"
                          .text
                          .color(Colors.white.withOpacity(0.5))
                          .make(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),

                ///MISC loggert
                Obx(
                  () => ClipRRect(
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          // gradient: LinearGradient(colors: [const Color.fromARGB(255, 125, 166, 237).withOpacity(0.2),const Color.fromARGB(255, 82, 129, 169).withOpacity(0.2)]),
                          borderRadius: BorderRadius.circular(20)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                        child: Column(
                          children: [
                            ListTile(
                                leading: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.height * 0.05,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromARGB(255, 134, 148, 177)
                                          .withOpacity(0.2)),
                                  child: Icon(
                                    Icons.bed_sharp,
                                    color: Colors.white,
                                  ),
                                ),
                                title: "Rooms".text.white.make(),
                                trailing: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            update.removeRoom();
                                          },
                                          icon: Icon(
                                            CupertinoIcons.minus,
                                            size: 15,
                                            color: Colors.white,
                                          )),
                                      update.Rooms.value.text
                                          .minFontSize(18)
                                          .white
                                          .make(),
                                      IconButton(
                                          onPressed: () {
                                            update.addRoom();
                                          },
                                          icon: Icon(
                                            Icons.add,
                                            size: 15,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                ).pLTRB(20, 0, 0, 0)),
                            ListTile(
                                leading: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.height * 0.05,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromARGB(255, 134, 148, 177)
                                          .withOpacity(0.4)),
                                  child: Icon(
                                    Icons.person_add_alt,
                                    color: Colors.white,
                                  ),
                                ),
                                title: "Adults".text.white.make(),
                                subtitle: "Age 13 or above"
                                    .text
                                    .color(Colors.white.withOpacity(0.5))
                                    .make(),
                                trailing: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            update.removeAdults();
                                          },
                                          icon: Icon(
                                            CupertinoIcons.minus,
                                            size: 15,
                                            color: Colors.white,
                                          )),
                                      update.Adults.value.text
                                          .minFontSize(18)
                                          .white
                                          .make(),
                                      IconButton(
                                          onPressed: () {
                                            update.addAdults();
                                          },
                                          icon: Icon(
                                            Icons.add,
                                            size: 15,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                ).pLTRB(20, 0, 0, 0)),
                            ListTile(
                                leading: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.height * 0.05,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromARGB(255, 134, 148, 177)
                                          .withOpacity(0.4)),
                                  child: Icon(
                                    Icons.child_care,
                                    color: Colors.white,
                                  ),
                                ),
                                title: "Children".text.white.make(),
                                subtitle: "Age 2-13"
                                    .text
                                    .color(Colors.white.withOpacity(0.5))
                                    .make(),
                                trailing: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            update.removechildren();
                                          },
                                          icon: Icon(
                                            CupertinoIcons.minus,
                                            size: 15,
                                            color: Colors.white,
                                          )),
                                      update.children.value.text
                                          .minFontSize(18)
                                          .white
                                          .make(),
                                      IconButton(
                                          onPressed: () {
                                            update.addchildren();
                                          },
                                          icon: Icon(
                                            Icons.add,
                                            size: 15,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                ).pLTRB(20, 0, 0, 0)),
                            ListTile(
                                leading: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.height * 0.05,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromARGB(255, 134, 148, 177)
                                          .withOpacity(0.4)),
                                  child: Icon(
                                    Icons.baby_changing_station,
                                    color: Colors.white,
                                  ),
                                ),
                                title: "Infants".text.white.make(),
                                subtitle: "Under 2"
                                    .text
                                    .color(Colors.white.withOpacity(0.5))
                                    .make(),
                                trailing: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            update.removeInfants();
                                          },
                                          icon: Icon(
                                            CupertinoIcons.minus,
                                            size: 15,
                                            color: Colors.white,
                                          )),
                                      update.Infants.value.text
                                          .minFontSize(18)
                                          .white
                                          .make(),
                                      IconButton(
                                          onPressed: () {
                                            update.addInfants();
                                          },
                                          icon: Icon(
                                            Icons.add,
                                            size: 15,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                ).pLTRB(20, 0, 0, 0)),
                          ],
                        ),
                      ),
                    ).p(10),
                  ).pLTRB(0, MediaQuery.of(context).size.height * 0.02, 0, 0),
                ),
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
              // Get.to(Get.to(Finalscreen(query: widget.title, days: widget.days,)));
              Get.to(Get.to(Reels(
                query: widget.title,
                days: widget.days,
              )));
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
