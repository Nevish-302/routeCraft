import 'dart:convert';

import 'package:ai_travel_planner/data/Repository/itenary.dart';
import 'package:ai_travel_planner/data/model/DayWiseModel.dart';
import 'package:ai_travel_planner/data/model/itenaryModel.dart';
import 'package:get/get.dart';

class FinalClass {
  static RxBool iLoaded = false.obs;
  static RxBool sLoaded = false.obs;
  static String query = '';
  static int days = 4;
  static Data itenary = Data();
  static DayWiseModel daywise = DayWiseModel();
}

Future<void> loadItinerary() async {
  ItenaryRepo repo = ItenaryRepo();
  final Data itenary =
      await repo.FetchItemAI(FinalClass.query, FinalClass.days * 2);
  print(itenary.toString());
  FinalClass.itenary = itenary;
  FinalClass.iLoaded.value = true;
}

Future<void> loadDaywise() async {
  ItenaryRepo repo = ItenaryRepo();
  int totDays = FinalClass.itenary.dayWiseItinerary!.length;
  String prompt = '';
  for (int i = 0; i < totDays; i++) {
    prompt += jsonEncode(FinalClass.itenary.dayWiseItinerary![i].toJson());
  }
  FinalClass.daywise = await repo.FetchDayWiseAI(prompt);
  FinalClass.sLoaded.value = true;
}
