import 'dart:ui';

import 'package:ai_travel_planner/data/Repository/itenary.dart';
import 'package:ai_travel_planner/data/static/commons.dart';
import 'package:ai_travel_planner/features/travel/screen/itenary/schedule.dart';
import 'package:ai_travel_planner/features/travel/screen/voice/RippleBlurred.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:get/get.dart';

class Translation extends StatefulWidget {
  const Translation({super.key});

  @override
  State<Translation> createState() => _TranslationState();
}

class _TranslationState extends State<Translation> {
  TextEditingController displayText = TextEditingController();
  var Gotit = "jaipur";
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  String _translation = '';
  final _items = CommonData.locale;
  final localeMap = CommonData.localeMap;
  String? lang1;
  String? lang2;

  @override
  void initState() {
    super.initState();
    setState(() {
      lang1 = _items[0];
      lang2 = _items[1];
    });

    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(
        onResult: _onSpeechResult, localeId: localeMap[lang1] ?? 'en-US');
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
      }
    });
  }

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Positioned(
          //   bottom: 20,
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     child: Center(
          //       child: RippleAnimationBlurred(
          //         child: Icon(
          //           _speechToText.isNotListening
          //               ? Iconsax.microphone_slash
          //               : Iconsax.microphone,
          //           color: Colors.white,
          //         ),
          //         color: Colors.white,
          //         delay: const Duration(milliseconds: 600),
          //         repeat: true,
          //         minRadius: MediaQuery.of(context).size.width,
          //         ripplesCount: 6,
          //         duration: const Duration(seconds: 12),
          //       ),
          //     ),
          //   ),
          // ),
          // Positioned.fill(
          //   child: BackdropFilter(
          //     filter: ImageFilter.blur(
          //       sigmaX: 10.0, // Adjust blur intensity
          //       sigmaY: 10.0, // Adjust blur intensity
          //     ),
          //     child: Container(
          //       color: Colors.transparent, // Maintain transparency
          //     ),
          //   ),
          // ),
          Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropdownButton<String>(
                      value: lang1,
                      underline: Container(),
                      dropdownColor: Colors.black,
                      hint: Text('From'),
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                      icon: Icon(Icons.keyboard_arrow_down_outlined),
                      iconSize: 20,
                      items:
                          _items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          lang1 = newValue;
                        });
                      }),
                  DropdownButton<String>(
                      value: lang2,
                      icon: Icon(Icons.keyboard_arrow_down_outlined),
                      iconSize: 20,
                      dropdownColor: Colors.black,
                      underline: Container(),
                      hint: Text('From'),
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                      items:
                          _items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          lang2 = newValue;
                        });
                      })
                ],
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: TextField(
                  maxLines: 5,
                  controller: TextEditingController(text: _lastWords),
                  onChanged: (val) {
                    _lastWords = val;
                  },
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: TextField(
                  maxLines: 5,
                  controller: TextEditingController(text: _translation),
                  onChanged: (val) {
                    _lastWords = val;
                  },
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(fontSize: 20, color: Colors.white),
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
                      : _speechEnabled
                          ? 'Tap the microphone to start listening...'
                          : 'Speech not available',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(color: Colors.grey, fontSize: 15)),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize:
              _lastWords.isEmpty ? MainAxisSize.min : MainAxisSize.max,
          children: [
            FloatingActionButton.large(
              shape: CircleBorder(),
              foregroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
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
            _lastWords.isEmpty
                ? Container(
                    width: 0,
                  )
                : FloatingActionButton.large(
                    shape: CircleBorder(),
                    foregroundColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    onPressed: () async {
                      ItenaryRepo rep = ItenaryRepo();
                      String jack = await rep.Translate(
                          _lastWords, lang1 ?? 'English', lang2 ?? 'Hindi');
                      setState(() {
                        _translation = jack;
                      });
                    },
                    tooltip: 'Listen',
                    child: Icon(
                      Icons.translate,
                      color: Colors.white,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
