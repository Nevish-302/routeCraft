import 'package:ai_travel_planner/features/travel/screen/final/finalScreen.dart';
import 'package:ai_travel_planner/features/travel/screen/home/homescreen.dart';
import 'package:ai_travel_planner/features/travel/screen/seemore/seenore.dart';
import 'package:ai_travel_planner/features/travel/screen/timeline2.dart';
import 'package:ai_travel_planner/maps.dart';
import 'package:ai_travel_planner/navigationmenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'features/travel/screen/timeline.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      home:  NavigationMenu(),
    );
  }
}