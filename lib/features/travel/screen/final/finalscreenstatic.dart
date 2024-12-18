import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

import 'package:ai_travel_planner/data/Repository/itenary.dart';
import 'package:ai_travel_planner/data/model/itenaryModel.dart';
import 'package:ai_travel_planner/features/travel/screen/final/finalClass.dart';
import 'package:ai_travel_planner/features/travel/screen/final/widget/infiniteDraggableSlider/coverImage.dart';
import 'package:ai_travel_planner/features/travel/screen/final/widget/infiniteDraggableSlider/infiniteDraggableSlider.dart';
import 'package:ai_travel_planner/features/travel/screen/seemore/seenore.dart';
import 'package:ai_travel_planner/features/travel/screen/timeline/timeline2static.dart';
import 'package:ai_travel_planner/features/travel/screen/timeline2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class Finalscreenstatic extends StatefulWidget {
  Finalscreenstatic({
    super.key,
    required this.query,
    required this.days,
    required this.itenary,
  });
  String query;
  final int days;
  Data itenary;

  @override
  State<Finalscreenstatic> createState() => _FinalscreenstaticState();
}

class _FinalscreenstaticState extends State<Finalscreenstatic> {
  List<String> image = [
    "asset/travel1.jpg",
    "asset/travel2.jpg",
    "asset/travel3.jpg",
    "asset/travel1.jpg",
    "asset/travel2.jpg",
    "asset/travel3.jpg",
  ];

  List<String> tabText = ["Languages", "Ocean", "Climate", "Cuisine", "Mood"];

  String tex =
      '''You’re an experienced travel planner who has helped countless adventurers create bespoke travel itineraries based on their interests and preferences. One of your specialties is curating personalized travel plans that cater to individuals who are extroverted and have a taste for thrilling activities like swimming, skydiving, dancing, shopping, exploring different cultures, and discovering hidden gems around the world.
Your task is to create a customized travel itinerary for an extroverted individual who loves swimming, skydiving, dancing, shopping, immersing themselves in different cultures, and uncovering hidden gems. The itinerary should include the best destinations and activities that cater to these interests, ensuring a well-rounded and unforgettable travel experience.
Remember to consider each activity carefully, suggest suitable destinations, and provide a mix of popular attractions and off-the-beaten-path experiences to cater to the traveler’s adventurous spirit and outgoing nature.
For example, when recommending a destination for swimming, consider suggesting pristine beaches with clear waters such as the Maldives or vibrant swimming holes like the cenotes in Mexico. For dancing, recommend cities known for their lively nightlife and dance clubs such as Havana, Cuba, or Rio de Janeiro, Brazil. When highlighting hidden gems, suggest lesser-known spots like the colorful village of Chefchaouen in Morocco or the secluded beaches of Fernando de Noronha in Brazil.''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "asset/sky1.jpg",
                fit: BoxFit.fill,
              )),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    title: Text(
                      "Your Legend",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            int totDays =
                                widget.itenary.dayWiseItinerary!.length;
                            String prompt = '';
                            for (int i = 0; i < totDays; i++) {
                              prompt += jsonEncode(
                                  widget.itenary.dayWiseItinerary![i].toJson());
                            }
                            print(prompt);
                            print("prompt");
                            if (FinalClass.sLoaded.value)
                              Get.to(TimeLine2static(
                                query: prompt,
                                itenary: FinalClass.daywise,
                              ));
                          },
                          icon: Obx(() => Icon(
                                Iconsax.map,
                                color: FinalClass.sLoaded.value
                                    ? Colors.white
                                    : Colors.grey,
                              )))
                    ],
                  ),

                  // Center(
                  //     child: Text(
                  //       "Your Legend",
                  //       style: GoogleFonts.poppins(
                  //           textStyle: TextStyle(
                  //               fontSize: 30,
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.bold)),
                  //     )),

                  ///TAbs
                  SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceEvenly,
                    spacing: 10,
                    runSpacing: 10,
                    children: tabText.map((text) {
                      return GlassContainer(
                        borderRadius: BorderRadius.circular(100),
                        blur: 0.1,
                        child: Container(
                          height: 40,
                          width: 100,
                          child: Center(
                            child: Text(
                              text,
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  Row(
                    children: [
                      Text(
                        'Top Attractions',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text('More(243)',
                          style: TextStyle(
                              color: Colors.white30,
                              fontWeight: FontWeight.bold))
                    ],
                  ).pOnly(top: 10),
                  SizedBox(
                    height: 20,
                  ),

                  ///Image slider
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: InfiniteDragableSlider(
                      iteamCount: widget.itenary.places!.length,
                      itemBuilder: (context, index) => MagazineCoverImage(
                        height: 290,
                        asset: widget.itenary.places![index].imageLink!,
                      ),
                    ),
                  ),

                  ///tags
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'TRANSPORT',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ).p(5),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .05,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: ListView.builder(
                        itemCount: widget.itenary.transport!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext, x) {
                          return ElevatedButton(
                              onPressed: () => {},
                              child: Text(
                                widget.itenary.transport![x],
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.white10),
                              )).p(5);
                        }),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'EXPERIENCES',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ).p(5),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .05,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: ListView.builder(
                        itemCount: widget.itenary.experiences!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext, x) {
                          return ElevatedButton(
                              onPressed: () => {},
                              child: Text(
                                widget.itenary.experiences![x],
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.white10),
                              )).p(5);
                        }),
                  ),

                  ///Places card
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'ITINERARY',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.amber, fontWeight: FontWeight.bold),
                    ).p(5),
                  ),
                  GlassContainer(
                    blur: 0.2,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.itenary.places!.length,
                        itemBuilder: (BuildContext, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 180,
                              child: Row(
                                children: [
                                  Container(
                                    height: 200,
                                    width: 150,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        widget
                                            .itenary.places![index].imageLink!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.itenary.places![index].name!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          widget.itenary.places![index]
                                              .attraction!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: 15,
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          widget.itenary.places![index]
                                              .visitTime!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: 15,
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () => Get.to(SeeMore(
                                                item: widget
                                                    .itenary.places![index],
                                              )),
                                              child: GlassContainer(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: Colors.transparent),
                                                width: 40,
                                                height: 40,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 40,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 35.0),
                                                    child: Icon(
                                                      Iconsax.arrow_right_15,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                final placeName = widget.itenary
                                                    .places![index].name;
                                                final googleUrl =
                                                    'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(placeName!)}';

                                                try {
                                                  final uri =
                                                      Uri.parse(googleUrl);
                                                  if (await canLaunchUrl(uri)) {
                                                    await launchUrl(uri);
                                                  } else {
                                                    throw 'Could not open the map.';
                                                  }
                                                } catch (e) {
                                                  // Handle the error appropriately
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content:
                                                            Text('Error: $e')),
                                                  );
                                                }
                                              },
                                              child: GlassContainer(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: Colors.transparent),
                                                width: 40,
                                                height: 40,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 40,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5.0),
                                                    child: Icon(
                                                      Icons.location_on,
                                                      color: Colors.red,
                                                      size: 20,
                                                    ),
                                                  ),
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
                          );
                        },
                      ),
                    ),
                  ),

                  ///Day line
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'DAYWISE ITINEARY',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ).p(5),
                  ).p(10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                        height: MediaQuery.of(context).size.height * .30,
                        width: MediaQuery.of(context).size.width,
                        //decoration: BoxDecoration(image:DecorationImage(image: AssetImage('lib/assets/DayWiseLine.png'), fit: BoxFit.cover)),
                        child: ListView.builder(
                            itemCount: widget.itenary.dayWiseItinerary!.length!,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext, x) {
                              return Column(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height * .1,
                                    width:
                                        MediaQuery.of(context).size.width * .35,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage('asset/DayLine.png'),
                                            fit: BoxFit.cover)),
                                  ),
                                  for (int m = 0;
                                      m <
                                          widget.itenary.dayWiseItinerary![x]
                                              .places!.length;
                                      m++)
                                    Text('|',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 6)),
                                  for (int m = 0;
                                      m <
                                          widget.itenary.dayWiseItinerary![x]
                                              .places!.length;
                                      m++)
                                    Text('|',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 6)),
                                  Container(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(56, 58, 60, 1),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          topLeft: Radius.circular(20)),
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.itenary.dayWiseItinerary![x]
                                              .day!,
                                          style: TextStyle(color: Colors.amber),
                                        ),
                                        for (var i = 0;
                                            i <
                                                widget
                                                    .itenary
                                                    .dayWiseItinerary![x]
                                                    .places!
                                                    .length;
                                            i++)
                                          Text(
                                              "* ${widget.itenary.dayWiseItinerary![x].places![i]}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12))
                                      ],
                                    ).p(4),
                                  ).p(5),
                                ],
                              );
                            })),
                  ),

                  ///cost
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'ESTIMATED COSTS',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ).p(5),
                  ).p(10),
                  GlassContainer(
                      blur: .2,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(children: [
                        Row(children: [
                          Text("Accomodation",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(color: Colors.white))),
                          Spacer(),
                          Text(
                              widget.itenary.estimatedCost!.accomodation
                                  .toString(),
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(color: Colors.white)))
                        ]).p(3),
                        Row(children: [
                          Text("Activities",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(color: Colors.white))),
                          Spacer(),
                          Text(
                              widget.itenary.estimatedCost!.activities
                                  .toString(),
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(color: Colors.white)))
                        ]).p(3),
                        Row(children: [
                          Text("Food",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(color: Colors.white))),
                          Spacer(),
                          Text(widget.itenary.estimatedCost!.food.toString(),
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(color: Colors.white)))
                        ]).p(3),
                        Row(children: [
                          Text("Travel", style: TextStyle(color: Colors.white)),
                          Spacer(),
                          Text(
                              widget.itenary.estimatedCost!.transport
                                  .toString(),
                              style: TextStyle(color: Colors.white))
                        ]).p(3),
                      ]).pOnly(left: 20, top: 10, bottom: 10, right: 20)),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
