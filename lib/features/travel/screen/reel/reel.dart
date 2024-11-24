import 'dart:convert';

import 'package:ai_travel_planner/env/env.dart';
import 'package:ai_travel_planner/features/travel/screen/final/finalClass.dart';
import 'package:ai_travel_planner/features/travel/screen/final/finalScreen.dart';
import 'package:ai_travel_planner/features/travel/screen/final/finalscreenstatic.dart';
import 'package:ai_travel_planner/features/travel/screen/final/widget/infiniteDraggableSlider/infiniteDraggableSlider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class Reels extends StatefulWidget {
  const Reels({super.key, required this.query, required this.days});
  final String query;
  final int days;
  @override
  State<Reels> createState() => _ReelsState();
}

late Future<void> _initialize;

class _ReelsState extends State<Reels> {
  bool loaded = false;
  bool sloaded = false;
  List<VideoPlayerController?> controllers =
      List<VideoPlayerController?>.filled(5, null, growable: true);
// Create additional controllers as needed
  void initState() {
    // TODO: implement initState
    super.initState();

    // _controller = VideoPlayerController.networkUrl(Uri.parse("https://videos.pexels.com/video-files/3833491/3833491-hd_1080_1920_30fps.mp4"))..addListener(_videoListener);
    FinalClass.query = widget.query;
    FinalClass.days = widget.days;
    controllers[0] = VideoPlayerController.networkUrl(Uri.parse(
        "https://videos.pexels.com/video-files/3833491/3833491-hd_1080_1920_30fps.mp4"));
    _initialize = controllers[0]!.initialize().then((value) {
      setState(() {});
    });
    controllers[1] = VideoPlayerController.networkUrl(Uri.parse(
        "https://videos.pexels.com/video-files/2519660/2519660-uhd_2560_1440_24fps.mp4"));
    controllers[2] = VideoPlayerController.networkUrl(Uri.parse(
        "https://videos.pexels.com/video-files/1994828/1994828-hd_1920_1080_24fps.mp4"));
    controllers[3] = VideoPlayerController.networkUrl(Uri.parse(
        "https://videos.pexels.com/video-files/2023708/2023708-hd_720_1280_30fps.mp4"));
    controllers[4] = VideoPlayerController.networkUrl(Uri.parse(
        "https://videos.pexels.com/video-files/2053855/2053855-uhd_2560_1440_30fps.mp4"));
    // _initializeVideo(widget.query, j);
    // TryByFunc();
    controllers[1]!.initialize().then((value) {
      setState(() {});
    });
    controllers[2]!.initialize().then((value) {
      setState(() {});
    });
    controllers[3]!.initialize().then((value) {
      setState(() {});
    });
    controllers[4]!.initialize().then((value) {
      setState(() {});
    });
    fetchPexelsVideoList(
        'IhcGlY1ZhLm51Ye71hrMT2rVm5C8ClniHyCIIAovFDkeHjz7JyKoAawJ',
        widget.query);
    loadItinerary().then((value) {
      setState(() {
        loaded = true;
      });
      loadDaywise().then((value) => setState(() {
            sloaded = true;
          }));
    });
    setState(() {});
  }

  Future<void> fetchPexelsVideoList(String ApiKey, String placeName) async {
    final url =
        'https://api.pexels.com/videos/search?query=${placeName}&per_page=6';
    final apiKey = ApiKey; // Replace with your actual API key

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': apiKey,
      },
    );
    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("JJJJJ");
        print(data["videos"].length);
        print(data["videos"][0]);
        print(data["videos"].length);
        print(data["videos"][1]);
        for (int i = 0; i < 5; i++) {
          print(data["videos"][0]['video_files'][i]["link"]);
          print(data["videos"][1].toString());
          int hd = 0;
          try {
            if (data["videos"][i]['video_files'][1]["quality"] == 'hd') {
              hd = 1;
            }
            if (data["videos"][i]['video_files'][2]["quality"] == 'hd') {
              hd = 2;
            }
          } catch (e) {
            print('not that many videos');
          }
          print("homely");
          // videosReel.add(data["videos"][i]['video_files'][0]["link"]);
          controllers[i] = VideoPlayerController.networkUrl(
              Uri.parse(data["videos"][i]['video_files'][hd]["link"]));
          _initialize = controllers[i]!.initialize().then((value) {
            setState(() {});
          });
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print("fetching video failed");
      // videosReel.add('https://videos.pexels.com/video-files/3616039/3616039-hd_1920_1080_30fps.mp4');
      // videosReel.add('https://videos.pexels.com/video-files/3616039/3616039-hd_1920_1080_30fps.mp4');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white.withOpacity(0.6),
        title: Center(
            child: Container(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Enjoy',
                      style: GoogleFonts.protestGuerrilla(fontSize: 60),
                    ),
                    loaded
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipOval(
                              child: InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.white),
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.black.withOpacity(.5),
                                  ),
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    size: 50,
                                    color:
                                        sloaded ? Colors.amber : Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  Get.to(Finalscreenstatic(
                                      query: FinalClass.query,
                                      days: FinalClass.days,
                                      itenary: FinalClass.itenary));
                                },
                              ),
                            ),
                          )
                        : SizedBox(),
                  ],
                ))),
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
          future: _initialize,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: InfiniteDragableSlider(
                    iteamCount: 5,
                    itemBuilder: (context, i) => SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: ClipRect(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: FittedBox(
                              fit: BoxFit
                                  .cover, // This scales and crops the video to fill the container
                              child: ClipRect(
                                child: SizedBox(
                                  width: controllers[i]!.value.size.width /
                                      (controllers[i]!.value.size.height /
                                          MediaQuery.of(context).size.height),
                                  // width: MediaQuery.of(context).size.width ,
                                  height: MediaQuery.of(context).size.height,
                                  // height: controllers[i]!.value.size.height /(controllers[i]!.value.size.width / MediaQuery.of(context).size.width) ,

                                  child: InkWell(
                                    child: VideoPlayer(controllers[i]!),
                                    onTap: () {
                                      print(
                                          "tapped ${controllers[i]!.value.isPlaying}");
                                      if (controllers[i]!.value.isPlaying) {
                                        controllers[i]!.pause();
                                      } else {
                                        controllers[i]!.play();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else
              return const Center(
                child: CircularProgressIndicator(),
              );
          }),
    );
    ;
  }
}
