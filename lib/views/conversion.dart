import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
import 'package:flutter/material.dart';


class RandomImage extends StatelessWidget {
  final int random;
  RandomImage({this.random});

  @override
  Widget build(BuildContext context) {
    if(random == 0){
      return Image.asset('assets/type-1.png');
    }if(random == 1){
      return Image.asset('assets/type-2.png');
    }if(random == 2){
      return Image.asset('assets/type-3.png');
    }if(random == 3){
      return Image.asset('assets/type-4.png');
    }if(random == 4){
      return Lottie.asset('assets/type-5.json', repeat: true, animate: true);
    }if(random == 5){
      return Lottie.asset('assets/type-6.json', repeat: true, animate: true);
    }
  }
}

class Translation extends StatefulWidget {
  @override
  _TranslationState createState() => _TranslationState();
}


class _TranslationState extends State<Translation> {
  TextEditingController _controller = TextEditingController();
  FlutterTts flutterTts = FlutterTts();
  String _hindiText = 'परिणामों के लिए कुछ लिखें!';
  int _random = 0;


  Color _backgroundColor = Colors.grey[50];
  Color _blackWhite = Colors.grey[50];
  Color _greyWhite = Colors.white;
  Color _greyDark = Colors.grey[300];
  Color _appBar = Colors.red;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var rng = new Random();
      setState(() {
        _random = rng.nextInt(6);
        print(_random);
      });
      _initDarkResolve();
  }
  _initDarkResolve() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('dark')){
      setState(() {
        _backgroundColor = Colors.grey[900];
        _blackWhite = Colors.white;
        _greyWhite = Colors.white;
        _appBar = Colors.red[700];
        _greyDark = Colors.grey[800];

      });
    }
    if(prefs.getBool('dark') == false){
      setState(() {
        _backgroundColor = Colors.grey[50];
        _blackWhite = Colors.black;
         _greyDark = Colors.grey[300];
        _greyWhite = Colors.grey;
        _appBar = Colors.red;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    GoogleTranslator translator = GoogleTranslator();


    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: _appBar,
        title: Text(
          'Verbic',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Colors.white
            )
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RandomImage(random: _random,),
            Container(
              margin: const EdgeInsets.all(28.0),
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: _greyDark,
                borderRadius: BorderRadius.circular(10)
              ),
              child: TextFormField(
                  onChanged: (val) async{
                      var translation = await translator.translate(val, from: 'en', to: 'hi');

                      if(_controller.text != null){
                        setState(() {
                          _hindiText = translation.toString();
                          print(_hindiText);
                        });
                      }
                      if (_controller.text == ""){
                        print('some');
                        setState(() {
                          _hindiText = 'परिणामों के लिए कुछ लिखें!';
                        });
                      }

                  },
                  controller: _controller,
                  style: GoogleFonts.poppins(
                    color: _blackWhite
                  ),
                  decoration: InputDecoration(
                    hintText: 'Type something to translate...',
                    hintStyle: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: _greyWhite
                      )
                    ),
                    fillColor: _greyWhite,
                    border: InputBorder.none
                  ),
              ),
            ),
            // SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                child: Text(
                  _hindiText,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 25,
                      color: Colors.redAccent
                    )
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(icon: Icon(Icons.volume_up, color: _blackWhite,), onPressed: () async{
                    await flutterTts.setLanguage("en-IN");
                    await flutterTts.speak(_hindiText.toString());
                  }),

                  IconButton(icon: Icon(Icons.copy, color: _blackWhite,), onPressed: () {
                    Clipboard.setData(new ClipboardData(text: _hindiText));
                    Scaffold.of(context).showSnackBar(new SnackBar(
                      content: new Text('Copied to Clipboard!'),
                    ));
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



