import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalityPref {
  static RxString name = ''.obs;
  static String lang = 'English';
  static int personality = 2; // Default to 'both'
  static int tourismInterest = 2; // Default to 'both'
  static int natureVsCity = 2; // Default to 'both'
  static int adventureRelaxation = 2; // Default to 'both'
  static int foodie = 1;
  static RxInt icon = 1.obs; // Default to 'yes'
}
