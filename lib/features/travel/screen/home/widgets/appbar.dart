import 'dart:ffi';

import 'package:ai_travel_planner/features/travel/screen/user/personalClass.dart';
import 'package:ai_travel_planner/features/travel/screen/user/personality.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBarWelcome extends StatefulWidget {
  const AppBarWelcome({
    super.key,
  });

  @override
  State<AppBarWelcome> createState() => _AppBarWelcomeState();
}

class _AppBarWelcomeState extends State<AppBarWelcome> {
  int profileIcon = 0;
  String name = "John Doe";
  bool isDone = false;
  @override
  void initState() {
    _loadPreferences();
    super.initState();
  }

  void _loadPreferences() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    PersonalityPref.personality = _prefs.getInt('personality') ?? 2;
    PersonalityPref.lang = _prefs.getString('lang') ?? 'English';
    PersonalityPref.name.value = _prefs.getString('user_name') ?? '';
    // if(PersonalityPref.name.value.length ==0)
    //  {
    //    PersonalityPref.name.value = "Traveller";
    //  }
    PersonalityPref.icon.value = _prefs.getInt('icon') ?? 1;
    PersonalityPref.tourismInterest = _prefs.getInt('tourismInterest') ?? 2;
    PersonalityPref.natureVsCity = _prefs.getInt('natureVsCity') ?? 2;
    PersonalityPref.adventureRelaxation =
        _prefs.getInt('adventureRelaxation') ?? 2;
    PersonalityPref.foodie = _prefs.getInt('foodie') ?? 1;
  }

  Future getProfileIcon() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int Icon = await _prefs.getInt('icon') ?? 1;
    String user = await _prefs.getString('user_name') ?? "John Doe";
    if (user == '') user = "John Doe";
    print("icon" + '${Icon}');
    setState(() {
      profileIcon = Icon;
      name = user;
      isDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() => Text(
                "Hi, ${PersonalityPref.name.value.length == 0 ? 'Traveller' : PersonalityPref.name.value.length > 10 ? PersonalityPref.name.value.substring(0, 10) : PersonalityPref.name.value}!",

                overflow: TextOverflow.ellipsis,
                maxLines: 1, // Limit to one line
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    height: 1,
                    letterSpacing: 0.0,
                    wordSpacing: 0.0,
                  ),
                ),
              )),
          InkWell(
            child: Obx(() => Image.asset(
                  'asset/${PersonalityPref.icon.value}.png',
                  width: 30, // Adjust size as needed
                  height: 30, // Adjust size as needed
                  fit: BoxFit.cover,
                )),
            onTap: () {
              Get.to(PersonalityPreferencesPage());
            },
          ),
        ],
      ),
    );
  }
}
