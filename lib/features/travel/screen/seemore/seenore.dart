import 'dart:convert';

import 'package:ai_travel_planner/data/model/itenaryModel.dart';
import 'package:ai_travel_planner/env/env.dart';
import 'package:ai_travel_planner/maps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import '../final/widget/infiniteDraggableSlider/coverImage.dart';
import '../final/widget/infiniteDraggableSlider/infiniteDraggableSlider.dart';
import 'package:http/http.dart' as http;

class SeeMore extends StatefulWidget {
  const SeeMore({super.key, required this.item});

  final Places item;

  @override
  State<SeeMore> createState() => _SeeMoreState();
}

List<String> images = [''];

class _SeeMoreState extends State<SeeMore> {
  void initState() {
    super.initState();
    setState(() {
      images[0] = "${widget.item.imageLink}";
    });
    fetchPexelsData(Env.PEXELS, "${widget.item.name}");
  }

  Future<void> fetchPexelsData(String ApiKey, String placeName) async {
    final url =
        'https://api.pexels.com/v1/search?query=${placeName}&per_page=5';
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
      int totalImages = data['photos']!.length;
      for (int i = 1; i < totalImages; i++) {
        setState(() {
          images.add(data["photos"][i]["src"]["medium"]);
        });
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  Future<void> fetchImageLink(String apiKey, String placeName) async {
    final String url = 'https://pixabay.com/api/';
    final Map<String, String> params = {
      'key': apiKey,
      'q': placeName,
      'image_type': 'photo',
      'per_page': '5',
    };
    print("jfkdlfjkld");
    final Uri uri = Uri.parse(url).replace(queryParameters: params);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['hits'] != null && data['hits'].isNotEmpty) {
          int totalImages = data['hits']!.length;
          for (int i = 1; i < totalImages; i++) {
            setState(() {
              images.add(data['hits'][i]['largeImageURL']);
            });
          } // Update your model or state with the image URL
        } else {
          print('No hits found for place: $placeName');
        }
      } else {
        print('Failed to load image data: ${response.statusCode}');
      }
    } catch (e) {
      print('Image error for place $placeName: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0.0,
        title: Center(
            child: Container(
          color: Colors.transparent,
          child: Text(
            widget.item.name!,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
        )),
      ),
      body: Stack(
        children: [
          Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "asset/sky1.jpg",
                fit: BoxFit.fill,
              )),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  ///Title

                  ///Image slider
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: InfiniteDragableSlider(
                      iteamCount: images.length,
                      itemBuilder: (context, index) => MagazineCoverImage(
                        height: 290,
                        asset: images[index],
                      ),
                    ),
                  ),

                  ///visit time
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Text(
                          'Visit time: ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.amber, fontWeight: FontWeight.bold),
                        ).p(5),
                        Text(
                          widget.item.visitTime!,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ).p(5),
                      ],
                    ),
                  ),

                  ///Attraction
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Text(
                          'Attraction: ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.amber, fontWeight: FontWeight.bold),
                        ).p(5),
                        Expanded(
                          child: Text(
                            widget.item.attraction!,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ).p(5),
                        ),
                      ],
                    ),
                  ),

                  ///childreen allowed
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Text(
                          'Children Allowed: ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.amber, fontWeight: FontWeight.bold),
                        ).p(5),
                        Text(
                          widget.item.childrenAllowed!,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ).p(5),
                      ],
                    ),
                  ),

                  ///Visit timr
                  ///DEscription
                  GlassContainer(
                    child: Text(
                      widget.item.description!,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      )),
                    ).p(20),
                  ).p(10),

                  ///map
                  GlassContainer(
                      child: Container(
                    height: 400,
                    child: MapTile(
                      item: widget.item,
                    ),
                  )).p(10)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
