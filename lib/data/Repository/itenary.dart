//toh repository ka kam kya hota h
//basically ye api see data leke model me dal deta h
//toh repository me api--> data--> model --> to be used in the application
import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'package:ai_travel_planner/data/model/DiscoverModel.dart';
import 'package:ai_travel_planner/data/model/itenaryModel.dart';
import 'package:ai_travel_planner/env/env.dart';
import 'package:ai_travel_planner/features/travel/screen/translate/translate.dart';
import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/api.dart';
import '../model/DayWiseModel.dart';
import 'package:http/http.dart' as http;

class ItenaryRepo {
  final Api _api = Api();

  Future<Data> FetchIten(String query) async {
    Response response = await _api.sendRequest.post(
      '/query',
      data: {'query': query},
    );
    log("dljkfhiosudhfiouksdhidsk");
    ApiResponse apiResponse = ApiResponse.fromResponse(response);
    log("jsdhaiksujgdjkhsagjhasgjshag");
    var item = Data.fromJson(apiResponse.data);
    log("khjsdgciusdgfiusdtyfgiusetfiudsgtfiusdgfiusdgfsdujfgsdkjhfgdsf\n\n\n\n");
    log(item.places![1].imageLink.toString() + "print hoja");
    return item;
  }

  ///day wise
  Future<Data> FetchItemAI(String query, int days) async {
    final SharedPreferences warningPrefs =
        await SharedPreferences.getInstance();
    String jack = await warningPrefs.getString('AIServer') ?? '';
    int personality = await warningPrefs.getInt('personality') ?? 2;
    int tourismInterest = await warningPrefs.getInt('tourismInterest') ?? 2;
    int natureVsCity = await warningPrefs.getInt('natureVsCity') ?? 2;
    int adventureRelaxation =
        await warningPrefs.getInt('adventureRelaxation') ?? 2;
    int foodie = await warningPrefs.getInt('foodie') ?? 1;
    log("hrllo");

    final model = GenerativeModel(
      model: 'gemini-1.5-flash-8b',
      apiKey: Env.GEMINI,
    );

    final prompt = '''
    you are an expert travel planner. Generate a${adventureRelaxation == 0 ? 'adventurous' : ''}${personality == 0 ? ' extrovert' : personality == 0 ? ' introvert' : ''} fictional traveler's log in the form of a list of travel destinations for a trip to ${query}, with a total of ${days} places.you can include clubs${tourismInterest == 1 ? '' : ', historical places'} , bars, forts, ${natureVsCity == 1 ? '' : 'nature,'}, ${foodie == 1 ? '' : 'restaurants,'} hidden gems, also some other famous places like museums etc, . Each destination should include the following details: name, description, locationName, longitude, latitude, attraction, image_link,totalTravelTimeInHours, VisitTime, estimatedFoodCost, dailyLog, estimatedTravelCost, estimatedStayCost, and childrenAllowed. Also make an array of Strings called experiences, an array of string called hotels, an array of strings called transport, a string called totalTravelTime, an object with key estimatedCost which contains values accomodation, activities, food, transport. Also include an array of objects with 2 fields first string day eg Day 1m second place names that divides places according to the number of days . The response should be in UTF-8 JSON format, all places enclosed in the 'places' field of the JSON to be returned without any extra comments or quote wrappers.
    
    example response:
{
  "places": places[],
  "totalTravelTime" : "String" (in hours),
  "hotels" : ["String"],
  "experiences" : ["String"],
  "transport" : ["String"],
  "dayWiseItinerary" : dayWiseItinerary[],
  "estimatedCost" : {
  "accomodation" : "String" (in USD),
  "activities" : "String" (in USD),
  "food": "String" (in USD),
  "transport": "String" (in USD),
  }
  
  json format for 1 places JSON object:
 {
  "name" : "String",
  "image_link" : "String" (fake short links like www.example.com),
  "locationName" : "String",
  "latitude": "String",
  "longitude" : "String",
  "dailyLog" : "String" (detailed log from the perspective of a traveller that visited and spent quality time at that place),
  "description" : "String",
  "childrenAllowed" : "String",
  "VisitTime" : "String",
  "attraction" : "String",
 }
 
   json format for 1 dayWiseItinerary JSON object:
    {
    "day" : "String" (eg Day 1),
    "places" ["String"] (number of places will be divided with at least 2 places a day and only the name of the place is put here) ,
    }
}
    
    ''';
    print(prompt);
    final content = [Content.text(prompt)];
    try {
      final response = await model.generateContent(content);
      print(response.text);
    } catch (e) {
      print("error" + e.toString());
    }
    final response = await model.generateContent(content);
    print(response.text);
    final jacky = await response.text ?? '';
    print("fjkdfjkd");
    final js =
        await jsonDecode(jacky.replaceAll('```json', '').replaceAll('```', ''));
    print(js.toString());
    log("dljkfhiosudhfiouksdhidsk");
    // ApiResponse apiResponse = ApiResponse.fromResponse(response);
    log("jsdhaiksujgdjkhsagjhasgjshag");
    // log(apiResponse.data.toString() + "apiresponse");
    var item = Data.fromJson(js);
    int totalPlaces = item.places!.length;
    for (int i = 0; i < totalPlaces; i++) {
      try {
        String name =
            await '${item.places![i].name} ${item.places![i].location}';
        List<Location> locations = await locationFromAddress(name);
        item.places![i].longitude = '${locations[0].longitude}';
        item.places![i].latitude = '${locations[0].latitude}';
      } catch (e) {
        print(e);
        print("error in location ${i}");
      }
    }
    print("dddddd");
    for (int i = 0; i < totalPlaces; i++) {
      try {
        String imagelink =
            await fetchPexelsData(Env.PEXELS, '${item.places![i].name}');
        item.places![i].imageLink = imagelink;
      } catch (e) {
        print(e.toString());
      }
    }

    print("locations[0].latitude.toString()");
    log("khjsdgciusdgfiusdtyfgiusetfiudsgtfiusdgfiusdgfsdujfgsdkjhfgdsf\n\n\n\n");
    log(item.places![1].imageLink.toString() + "print hoja");
    print(item.places![1].imageLink.toString() + "print hoja");
    print(item.places!.length.toString() + " places in total");
    return item;
  }

  Future<DayWiseModel> FetchDayWiseAI(String query) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-8b',
      apiKey: Env.GEMINI,
    );

    final prompt = '''
    you are an expert travel planner. Generate a fictional traveler's log in the form of a list of travel destinations for a trip to  the places with the  days as described 
 ${query} which contains values day, time, name, task, image, budget,location schedule it like giving the time when he reached the station and how he got to the hotel and schedule each minute of the person of all the days for which he is traveling and make it in complete sync. The response should be in UTF-8 JSON format, all places enclosed in the 'places' field of the JSON to be returned without any extra comments or quote wrappers.

example response:
{
  "items": [
    {
      "day": "String",  // Example: "Monday"
      "time": "String",  // Example: "10:00 AM"
      "name": "String",  // Example: "Visit to Eiffel Tower"
      "task": "String",  // Example: "Tour the Eiffel Tower and take photos"
      "image_link": "String",  (fake short links like www.example.com)
      "budget": "String",  // Example: "150 USD"
      "location": "String"  // Example: "Paris, France"
    }
  ], 
  ]''';
    print(prompt);
    final content = [Content.text(prompt)];
    try {
      final response = await model.generateContent(content);
      print(response.text);
    } catch (e) {
      print("error" + e.toString());
    }
    final response = await model.generateContent(content);
    print(response.text);
    final jacky = await response.text ?? '';
    print("fjkdfjkd");
    final js =
        await jsonDecode(jacky.replaceAll('```json', '').replaceAll('```', ''));
    print(js.toString());
    log("dljkfhiosudhfiouksdhidsk");
    // ApiResponse apiResponse = ApiResponse.fromResponse(response);
    log("jsdhaiksujgdjkhsagjhasgjshag");
    // log(apiResponse.data.toString() + "apiresponse");
    var item = DayWiseModel.fromJson(js);
    int totalPlaces = item.items!.length;
    for (int i = 0; i < totalPlaces; i++) {
      try {
        String imagelink =
            await fetchPexelsData(Env.PEXELS, '${item.items![i].name}');
        item.items![i].imageLink = imagelink;
      } catch (e) {
        print(e.toString());
      }
    }

    print("locations[0].latitude.toString()");
    log("khjsdgciusdgfiusdtyfgiusetfiudsgtfiusdgfiusdgfsdujfgsdkjhfgdsf\n\n\n\n");
    return item;
  }

  Future<DiscoverModel> FetchDiscoverAI() async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-8b',
      apiKey: Env.GEMINI,
    );

    final prompt = '''
    remember the answer should be in JSON format only no suggestions, comments or conversations needed.
    Based on today's temperature, weather and season, suggest me 10 places in the world to visit. they need not be close to each other. the output format should be an object with an array of objects enclosed within the items property without any unnecessary comments. object definition -> {items : [{ name : String(single word only), location : String, why: String, description : String, vacationDuration: String}]}
    ''';
    print(prompt);
    final content = [Content.text(prompt)];
    try {
      final response = await model.generateContent(content);
      print(response.text);
    } catch (e) {
      print("error" + e.toString());
    }
    final response = await model.generateContent(content);
    print(response.text);
    final jacky = await response.text ?? '';
    print("fjkdfjkd");
    final js =
        await jsonDecode(jacky.replaceAll('```json', '').replaceAll('```', ''));
//     final js = await jsonDecode('''
//       {
//   "items": [
//     {
//       "name": "Maldives",
//       "location": "Maldives",
//       "why": "Tropical paradise, ideal for beach relaxation",
//       "description": "Luxury resorts, pristine beaches, clear turquoise waters.",
//       "vacationDuration": "7 days"
//     },
//     {
//       "name": "Hawaii",
//       "location": "USA",
//       "why": "Volcanic landscapes, stunning beaches, lush rainforests",
//       "description": "Diverse landscapes, volcanic hikes, surfing, relaxation.",
//       "vacationDuration": "10 days"
//     },
//     {
//       "name": "Bora Bora",
//       "location": "French Polynesia",
//       "why": "Overwater bungalows, vibrant coral reefs, crystal-clear lagoons",
//       "description": "Romantic getaway, snorkeling, diving, luxurious relaxation.",
//       "vacationDuration": "5 days"
//     },
//     {
//       "name": "Costa Rica",
//       "location": "Costa Rica",
//       "why": "Abundant wildlife, rainforests, stunning beaches",
//       "description": "Adventure tourism, zip-lining, wildlife spotting, surfing.",
//       "vacationDuration": "10 days"
//     },
//     {
//       "name": "Santorini",
//       "location": "Greece",
//       "why": "Iconic white-washed villages, stunning sunsets, volcanic landscapes",
//       "description": "Picturesque views, delicious food, wine tasting, relaxing beaches.",
//       "vacationDuration": "7 days"
//     },
//     {
//       "name": "Kyoto",
//       "location": "Japan",
//       "why": "Ancient temples, serene gardens, traditional culture",
//       "description": "Cultural immersion, traditional tea ceremonies, beautiful gardens.",
//       "vacationDuration": "7 days"
//     },
//     {
//       "name": "Machu Picchu",
//       "location": "Peru",
//       "why": "Inca citadel, breathtaking mountain scenery, rich history",
//       "description": "Hiking, exploring ancient ruins, stunning views.",
//       "vacationDuration": "5 days"
//     },
//     {
//       "name": "Safari in Tanzania",
//       "location": "Tanzania",
//       "why": "Wildlife viewing, vast plains, stunning landscapes",
//       "description": "Game drives, wildlife spotting, hot air balloon safaris.",
//       "vacationDuration": "10 days"
//     },
//     {
//       "name": "Paris",
//       "location": "France",
//       "why": "Iconic landmarks, romantic atmosphere, rich culture",
//       "description": "Museums, art galleries, historical sites, delicious food.",
//       "vacationDuration": "5 days"
//     },
//     {
//       "name": "New York City",
//       "location": "USA",
//       "why": "Bustling metropolis, iconic landmarks, diverse culture",
//       "description": "Museums, Broadway shows, shopping, diverse culinary scene.",
//       "vacationDuration": "7 days"
//     }
//   ]
// }
//       ''');
    print(js.toString());
    log("dljkfhiosudhfiouksdhidsk");
    // ApiResponse apiResponse = ApiResponse.fromResponse(response);
    log("jsdhaiksujgdjkhsagjhasgjshag");
    // log(apiResponse.data.toString() + "apiresponse");
    var item = DiscoverModel.fromJson(js);
    // int totalPlaces = item.items!.length;
    // for (int i = 0; i < totalPlaces; i++) {
    //   try {
    //     String imagelink =
    //         // 'https://images.pexels.com/photos/2929906/pexels-photo-2929906.jpeg?auto=compress&cs=tinysrgb&h=350';
    //         await fetchPexelsData(Env.PEXELS, '${item.items![i].name}');
    //     item.items![i].imageLink = imagelink;
    //   } catch (e) {
    //     print(e.toString());
    //   }
    // }

    print("discover[0].latitude.toString()");
    log("khjsdgciusdgfiusdtyfgiusetfiudsgtfiusdgfiusdgfsdujfgsdkjhfgdsf\n\n\n\n");
    return item;
  }

  Future<String> Translate(String query, String lang1, String lang2) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-8b',
      apiKey: Env.GEMINI,
    );

    final prompt =
        '''you worked as a translator and have native experience of more than 20 years in $lang1 and $lang2 so would you please write the sentence translated from $lang1 to $lang2 and write the pronouncation of the said transalation in $lang2 iusing the alphabets or symbols used in $lang1 so that i person can pronounce the words written in $lang1. So please translate "${query} FROM $lang1 to $lang2 and the result should also be in the syllables of $lang1. Also just give the translated sentence without any explanations or extra comments."
 ''';
    print(prompt);
    final content = [Content.text(prompt)];
    try {
      final response = await model.generateContent(content);
      print(response.text);
    } catch (e) {
      print("error" + e.toString());
    }
    final response = await model.generateContent(content);
    print(response.text);
    final jacky = await response.text ?? '';

    log("fdfdfddfdfd\n\n\n\n");
    return jacky;
  }

  Future<String> fetchImageLink(String apiKey, String placeName) async {
    final String url = 'https://pixabay.com/api/';
    final Map<String, String> params = {
      'key': apiKey,
      'q': placeName,
      'image_type': 'photo',
      'per_page': '3',
    };
    print("jfkdlfjkld");
    final Uri uri = Uri.parse(url).replace(queryParameters: params);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['hits'] != null && data['hits'].isNotEmpty) {
          final String imageUrl = data['hits'][0]['largeImageURL'];
          print('Image URL: $imageUrl');
          // Update your model or state with the image URL
          return imageUrl;
        } else {
          print('No hits found for place: $placeName');
        }
      } else {
        print('Failed to load image data: ${response.statusCode}');
      }
    } catch (e) {
      print('Image error for place $placeName: $e');
    }
    return 'https://i.ibb.co/bXtZnP6/pexels-photo-1115175.jpg';
  }

  Future<String> fetchPexelsData(String ApiKey, String placeName) async {
    final url =
        'https://api.pexels.com/v1/search?query=${placeName}&per_page=1';
    final apiKey = ApiKey; // Replace with your actual API key

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // print('Response data: $data');
      print(data["photos"][0]["src"]["medium"]);
      return data["photos"][0]["src"]["medium"];
    } else {
      print('Request failed with status: ${response.statusCode}');
      return 'https://images.pexels.com/photos/774282/pexels-photo-774282.jpeg';
    }
  }

  Future<DayWiseModel> DayWise(String query) async {
    log("entereed");

    Response response = await _api.sendRequest.post(
      '/dayWiseQuery',
      data: {'query': query},
    );
    log("seent rqst");

    ApiResponse apiResponse = ApiResponse.fromResponse(response);
    log("parseed reesponse");
    var item = DayWiseModel.fromJson(apiResponse.data);
    log("itemm");
    log(item.items![0]!.name!);
    return item;
  }
}
