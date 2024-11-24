import 'package:ai_travel_planner/features/travel/screen/reel/reel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import 'home_suggestion_tab.dart';

class Suggestions extends StatelessWidget {
  const Suggestions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          InkWell(
            child: HomeSuggestionTab(
              child: Icon(
                Iconsax.search_normal,
                color: Colors.white,
              ),
            ),
            onTap: () => {Get.to(Get.to(Reels(query: 'Delhi', days: 8)))},
          ),
          SizedBox(
            width: 10,
          ),
          HomeSuggestionTab(
            child: Text(
              "🏝 Beach",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  height: 1,
                  letterSpacing: 0.0,
                  wordSpacing: 0.0,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          HomeSuggestionTab(
            child: Text(
              "⛳️ Auxiliary",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  height: 1,
                  letterSpacing: 0.0,
                  wordSpacing: 0.0,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          HomeSuggestionTab(
            child: Text(
              "🏔️️ Hills",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  height: 1,
                  letterSpacing: 0.0,
                  wordSpacing: 0.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
