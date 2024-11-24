import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  @override
  void initState() {
    // TODO: implement initState
    _loadPersonalisation();
    super.initState();
  }

  TextEditingController _controller = TextEditingController();

  void _loadPersonalisation() async {
    late SharedPreferences _prefs;
    _prefs = await SharedPreferences.getInstance();
    _controller.text = _prefs.getString("personalisation") ?? '';
  }

  void _savePersonalisation(value) async {
    late SharedPreferences _prefs;
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString("personalisation", value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      body: Container(
        color: Colors.black,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // color: Colors.black54,
                  width: MediaQuery.of(context).size.width * .9,
                  height: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('asset/person.png'))),
                ),
                Container(
                  color: Colors.black54,
                  width: MediaQuery.of(context).size.width * .9,
                  child: TextField(
                    minLines: 2,
                    maxLines: 5,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold), // Change the text color here
                    onChanged: (s) {
                      _savePersonalisation(s);
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Who Are You?',
                      labelStyle: TextStyle(),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "CHANGE",
                        style: GoogleFonts.bebasNeue(
                            color: Colors.deepPurpleAccent,
                            // fontWeight: FontWeight.w900,
                            fontSize: 30),
                      ),
                    ),
                    // decoration: BoxDecoration(color: Colors.blueAccent),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
