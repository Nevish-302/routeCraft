import 'dart:ui';

import 'package:ai_travel_planner/data/static/commons.dart';
import 'package:ai_travel_planner/features/travel/screen/itenary/schedule.dart';
import 'package:ai_travel_planner/features/travel/screen/user/personalClass.dart';
import 'package:ai_travel_planner/features/travel/screen/voice/RippleBlurred.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:get/get.dart';

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({super.key});

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  TextEditingController displayText = TextEditingController();
  var Gotit = "jaipur";
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  final localeMap = CommonData.localeMap;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(
        onResult: _onSpeechResult,
        localeId: localeMap[PersonalityPref.lang] ?? 'en-US');
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      // Check if the recognized words match a specific condition
      if (_lastWords.toLowerCase() == 'navigate') {
        // If condition met, navigate to AnotherScreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Scheduler(title: 'jaipur')),
        );
      }
    });
  }

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Center(child: Image.asset("asset/BHFO.gif")),
          Positioned(
            bottom: 20,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: RippleAnimationBlurred(
                  child: Icon(
                    _speechToText.isNotListening
                        ? Iconsax.microphone_slash
                        : Iconsax.microphone,
                    color: Colors.white,
                  ),
                  color: Colors.white,
                  delay: const Duration(milliseconds: 600),
                  repeat: true,
                  minRadius: MediaQuery.of(context).size.width,
                  ripplesCount: 6,
                  duration: const Duration(seconds: 12),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0, // Adjust blur intensity
                sigmaY: 10.0, // Adjust blur intensity
              ),
              child: Container(
                color: Colors.transparent, // Maintain transparency
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: TextField(
                  maxLines: 10,
                  controller: TextEditingController(text: _lastWords),
                  onChanged: (val) {
                    _lastWords = val;
                  },
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 130,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  // If listening is active show the recognized words
                  _speechToText.isListening
                      ? 'You can speak'
                      // If listening isn't active but could be tell the user
                      // how to start it, otherwise indicate that speech
                      // recognition is not yet ready or not supported on
                      // the target device
                      : _speechEnabled
                          ? 'Tap the microphone to start listening...'
                          : 'Speech not available',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),
            ),
          ),
          _lastWords.isEmpty
              ? Container()
              : Positioned(
                  bottom: 10,
                  right: 0,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: CircleBorder(),
                      ),
                      onPressed: () {
                        Get.to(Scheduler(title: _lastWords ?? " hg"));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(
                          Iconsax.arrow_right4,
                          color: Colors.white,
                        ),
                      )))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Stack(
          children: [
            FloatingActionButton.large(
              shape: CircleBorder(),
              foregroundColor: Colors.blue,
              backgroundColor: Colors.blue,
              onPressed:
                  // If not yet listening for speech start, otherwise stop
                  _speechToText.isNotListening
                      ? _startListening
                      : _stopListening,
              tooltip: 'Listen',
              child: Icon(
                _speechToText.isNotListening
                    ? Iconsax.microphone_slash
                    : Iconsax.microphone,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
