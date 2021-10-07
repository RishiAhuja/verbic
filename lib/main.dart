import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sizer/sizer_util.dart';
import 'package:sizer/sizer.dart';
import 'package:verbic_web/helper/image_view.dart';
import 'package:verbic_web/views/conversion.dart';
import 'package:verbic_web/views/conversion2.dart';
import 'package:verbic_web/views/history.dart';
import 'package:verbic_web/views/like.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'views/conversion.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:lottie/lottie.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(                           //return LayoutBuilder
      builder: (context, constraints) {
        return OrientationBuilder(                  //return OrientationBuilder
          builder: (context, orientation) {
            //initialize SizerUtil()
            SizerUtil().init(constraints, orientation);  //initialize SizerUtil
            return MaterialApp(
              theme: ThemeData(
                primarySwatch: Colors.orange,
              ),
              debugShowCheckedModeBanner: false,
              home: Splash()
            );
          },
        );
      },
    );
  }
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 1,
      navigateAfterSeconds: new MyHomePage(),
      photoSize: 100.0,
      title: new Text(
        'VERBIC',
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 30,
            color: Colors.redAccent
          )
        ),
      ),
      image: Image.asset('assets/icon.png'),
      backgroundColor: Colors.white,
      loadingText: Text(
        'MADE WITH PROUD IN INDIA',
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: Colors.redAccent
          )
        ),
      )
    );
  }
}

int _random = 0;
//--------------------//
Color _backgroundColor = Colors.grey[50];
Color _blackWhite = Colors.black;
Color _whiteGrey = Colors.white;
Color _greyWhite = Colors.grey;
Color _enterASearchTerm = Colors.grey[800];
Color _appBar = Colors.red;
//--------------------//
class RandomImage extends StatelessWidget {
  final int random;
  RandomImage({this.random});

  @override
  Widget build(BuildContext context) {
    if(random == 0){
      return Image.asset('assets/home/home1.png');
    }if(random == 1){
      return Image.asset('assets/home/home2.png');
    }if(random == 2){
      return Image.asset('assets/home/home3.png');
    }if(random == 3){
      return Image.asset('assets/home/home4.png');
    }if(random == 4){
      return Image.asset('assets/home/home5.png');
    }if(random == 5){
      return Image.asset('assets/home/home6.png');
    }if(random == 6){
      return Image.asset('assets/home/home7.png');
    }if(random == 7){
      return Lottie.asset('assets/lottie/1.json', repeat: true, animate: true);
    }if(random == 8){
      return Lottie.asset('assets/lottie/2.json', repeat: true, animate: true);
    }if(random == 9){
      return Lottie.asset('assets/lottie/3.json', repeat: true, animate: true);
    }if(random == 10){
      return Lottie.asset('assets/lottie/4.json', repeat: true, animate: true);
    }if(random == 11){
      return Lottie.asset('assets/lottie/5.json', repeat: true, animate: true);
    }
  }
}



class _extras extends StatefulWidget {

  @override
  __extrasState createState() => __extrasState();
}

class __extrasState extends State<_extras> {
  @override
  Widget build(BuildContext context) {
    if(SizerUtil.orientation == Orientation.portrait){
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Extras',
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: _enterASearchTerm
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Translation()),
                  );
                },
                child: Container(
                  width: (MediaQuery.of(context).size.width/2)-25,
                  margin: EdgeInsets.all(5),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: _backgroundColor,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          FlatButton(
                              color: _backgroundColor,
                              child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.asset('assets/trans.png')
                              ),
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Translation()),
                                );
                              }),
                          Text(
                            'English to Hindi',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 15,
                                    color: _blackWhite
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Translation2()),
                  );
                },
                child: Container(
                  width: (MediaQuery.of(context).size.width/2)-25,
                  margin: EdgeInsets.all(5),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: _backgroundColor,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          FlatButton(
                              color: _backgroundColor,
                              child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.asset('assets/trans2.png')
                              ),
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Translation2()),
                                );
                              }),
                          Text(
                            'Hindi to English',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 15,
                                    color: _blackWhite
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }else{
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Extras',
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: _enterASearchTerm
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Translation()),
                  );
                },
                child: Container(
                  width: (MediaQuery.of(context).size.width/2)-25,
                  height: (MediaQuery.of(context).size.height/3),
                  margin: EdgeInsets.all(5),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: _backgroundColor,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          FlatButton(
                              color: _backgroundColor,
                              child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.asset('assets/trans.png')
                              ),
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Translation()),
                                );
                              }),
                          Text(
                            'English to Hindi',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 15,
                                    color: _blackWhite
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Translation2()),
                  );
                },
                child: Container(
                  width: (MediaQuery.of(context).size.width/2)-25,
                  height: (MediaQuery.of(context).size.height/3),
                  margin: EdgeInsets.all(5),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: _backgroundColor,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          FlatButton(
                              color: _backgroundColor,
                              child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.asset('assets/trans2.png')
                              ),
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Translation2()),
                                );
                              }),
                          Text(
                            'Hindi to English',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 15,
                                    color: _blackWhite
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }
  }
}

class _enterWord extends StatefulWidget {
  @override
  __enterWordState createState() => __enterWordState();
}

class __enterWordState extends State<_enterWord> {
  @override
  Widget build(BuildContext context) {
    if(SizerUtil.orientation == Orientation.portrait){
      return
       Column(
         children: [
           RandomImage(random: _random,),
           Container(
             margin: EdgeInsets.only(top: 15),
             child: Center(
               child: Text(
                 "Please enter a search word..",
                 textAlign: TextAlign.center,
                 style: GoogleFonts.poppins(
                     textStyle: TextStyle(
                       fontWeight:  FontWeight.w400,
                       fontSize: 18,
                       color: _enterASearchTerm,
                     )
                 ),
               ),
             ),
           ),
         ],
       );
    }

    if(SizerUtil.orientation == Orientation.landscape){
      return
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 300, width: 300, child: RandomImage(random: _random,)),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Center(
                  child: Text(
                    "Please enter a search word..",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight:  FontWeight.w400,
                          fontSize: 18,
                          color: _enterASearchTerm,
                        )
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
    }
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _url = "owlbot.info";
  String _token = "d441964be0fd11166139246ec905ada64510f83d";
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  TextEditingController _controller = TextEditingController();
  FlutterTts flutterTts = FlutterTts();
  stt.SpeechToText _speech;
  bool _isListening = false;

  StreamController _streamController;
  Stream _stream;

  Timer _debounce;
  List<String> no_def = [];

  String _timeString;
  String _dateString;
  bool _isLiked = false;
  bool _isDark = false;







  void _getTime() {
    final String formattedDateTime =
    DateFormat('kk:mm:ss').format(DateTime.now()).toString();
    setState(() {
      _timeString = formattedDateTime;
      print(_timeString);
      print(_timeString);
    });
  }

  void _getDate() {
    final String formattedDateTime =
    DateFormat('dd-MM-yy').format(DateTime.now()).toString();
    setState(() {
      _dateString = formattedDateTime;
      print(_dateString);
    });
  }

  _initDarkResolve() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('dark')!=null){
      if(prefs.getBool('dark')){
        setState(() {
          _backgroundColor = Colors.grey[900];
          _enterASearchTerm = Colors.grey[50];
          _blackWhite = Colors.white;
          _whiteGrey = Colors.grey[900];
          _greyWhite = Colors.grey[50];
          _appBar = Colors.red[700];
          _isDark = true;
        });
      }
      if(prefs.getBool('dark') == false){
        setState(() {
          _backgroundColor = Colors.grey[50];
          _enterASearchTerm = Colors.grey[800];
          _blackWhite = Colors.black;
          _whiteGrey = Colors.white;
          _greyWhite = Colors.grey[600];
          _appBar = Colors.red;
          _isDark = false;
        });
      }
    }
}
  _search() async {
    _getTime();
    _getDate();
    setState(() {
      _isLiked = false;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_controller.text == null || _controller.text.length == 0) {
      _streamController.add(null);
      return;
    }

    if(_controller != null || _controller.text.length != 0 || _controller.text == '' || _controller.text == " "){
      FirebaseFirestore.instance.collection('${prefs.getString('collection')}').doc('history').collection('history').add({
        'search': _controller.text,
        'time': _timeString,
        'date': _dateString,
        'deleted': false
      });
    }

    _streamController.add("waiting");
    FirebaseFirestore.instance.collection('${prefs.getString('collection')}').doc('like').collection('like').where('word', isEqualTo: _controller.text).get().then((QuerySnapshot value) {
      value.docs.forEach((doc){
        print("${doc['word']}");
        setState(() {
          _isLiked = true;
        });
      });
    });
    Response response = await get(Uri.https(_url , '/api/v4/dictionary/' + _controller.text.trim()), headers: {"Authorization": "Token " + _token});
    _streamController.add(json.decode(response.body));
    print(response.body);
    print(json.decode(response.body));
  }

  _auth() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('collection') != null){
      print('userExists!');
    }
    else{
      final password = RandomPasswordGenerator();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("dark", false);
      String newPassword = password.randomPassword(true, true, true, true, 150);
      print(newPassword);
      FirebaseFirestore.instance.collection('$newPassword').add({
        'created': true
      }).then((value) async{
        await prefs.setString('collection', newPassword);
      });
    }
  }
  _like() async{
    _getDate();
    _getTime();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(_isLiked) {
      FirebaseFirestore.instance.collection('${prefs.getString('collection')}').doc('like').collection('like').add({
        'word': _controller.text,
        'time': _timeString,
        'date': _dateString,
        'deleted': false,
      }).then((value) {
        _scaffold.currentState.showSnackBar(SnackBar(content: Text('Added to liked words', style: GoogleFonts.poppins(),)));
      });
    }

    if(!_isLiked) {
      FirebaseFirestore.instance.collection('${prefs.getString('collection')}').doc('like').collection('like').where('word', isEqualTo: _controller.text).get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          print(doc["word"]);
          FirebaseFirestore.instance.collection('${prefs.getString('collection')}').doc('like').collection('like').doc(doc.id).delete().then((value) {
            _scaffold.currentState.showSnackBar(SnackBar(content: Text('Removed to liked words', style: GoogleFonts.poppins(),)));
          });
        });
      });
    }
  }
  _setDark() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('dark', true);
    setState(() {
      _backgroundColor = Colors.grey[900];
      _enterASearchTerm = Colors.grey[50];
      _blackWhite = Colors.white;
      _whiteGrey = Colors.grey[900];
      _greyWhite = Colors.grey[50];
      _appBar = Colors.red[700];
      _isDark = true;
    });
  }
  _setLight() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('dark', false);
    setState(() {
      _backgroundColor = Colors.grey[50];
      _enterASearchTerm = Colors.grey[800];
      _blackWhite = Colors.black;
      _whiteGrey = Colors.white;
      _greyWhite = Colors.grey[600];
      _appBar = Colors.red;
      _isDark = false;

    });
  }
  @override
  void initState() {
    super.initState();

    _streamController = StreamController();
    _stream = _streamController.stream;
    _auth();
    var rng = new Random();
    setState(() {
      _random = rng.nextInt(12);
      print(_random);
    });

    _initDarkResolve();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      key: _scaffold,
      appBar: AppBar(
        backgroundColor: _appBar,
        actions: [
          _isDark ?  Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isDark = false;
                });
                _setLight();
              },
              child: Icon(Icons.wb_sunny, color: _backgroundColor),
            ),
          ) :  Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isDark = true;
                });
                _setDark();
              },
              child: Icon(Icons.nightlight_round, color: _backgroundColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Like())),
              child: Icon(CupertinoIcons.heart_fill, color: _backgroundColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => History())),
              child: Icon(Icons.history, color: _backgroundColor),
            ),
          ),

        ],
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
              "Verbic",
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w600,
                color: _whiteGrey
              )
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12.0, bottom: 18.0),
                  decoration: BoxDecoration(
                    color: _backgroundColor,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: TextFormField(
                    style: GoogleFonts.poppins(color: _blackWhite),
                    onChanged: (String text) {
                      if (_debounce?.isActive ?? false) _debounce.cancel();
                      _debounce = Timer(const Duration(milliseconds: 1000), () {
                        _search();
                      });
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Search for a word",
                      hintStyle: GoogleFonts.poppins(color: _greyWhite),
                      contentPadding: EdgeInsets.fromLTRB(24, 0, 0, 0),
                      border: InputBorder.none,
                    ),
                    
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: _backgroundColor
                  ),
                  onPressed: () {
                    _search();
                  },
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
        child: StreamBuilder(
          stream: _stream,
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _enterWord(),
                      _extras()
                      // SizedBox(height: 40),

                    ],
                  ),
                ],
              );

            }

            if (snapshot.data == "waiting") {

              return Center(
                child: CircularProgressIndicator(),

              );
            }
            if (snapshot.data != null){
                no_def.insert(no_def.length, snapshot.data.toString());
                if(no_def.contains('[{message: No definition :(}]')){
                  no_def.clear();
                  return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/not-found.png'),
                          SizedBox(height: 20,),
                          Text(
                              "Can't find word",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 30,
                                color: Colors.black
                              )
                            ),
                          ),
                          Text(
                            "'${_controller.text.trim().toUpperCase()}'",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 30,
                                    color: Colors.black
                                )
                            ),
                          ),
                          SizedBox(height: 50),
                          Text(
                            'Try searching something else',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20
                              )
                            ),
                          )
                        ],
                      )
                  );
                }
            }

            return ListView.builder(
              itemCount: snapshot.data["definitions"].length,
              itemBuilder: (BuildContext context, int index) {
                return snapshot.data["message"] == "null" ?  null :
                ListBody(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Card(
                          color: _backgroundColor,
                          elevation: 3,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ImageView(url: snapshot.data['definitions'][index]['image_url'],))),
                                child: Container(
                                  child: snapshot.data['definitions'][index]['image_url'] != null ? SizedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: InteractiveViewer(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(30),
                                          child: Container(
                                            width: 150,
                                            height: 150,
                                            child: Image.network(
                                                snapshot.data['definitions'][index]['image_url']
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),) : null,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(20, 20, 10, 0),
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.amberAccent,
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Text(
                                    snapshot.data["definitions"][index]["type"].toUpperCase().toString(),
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                    child: Text(
                                      toBeginningOfSentenceCase( _controller.text.trim().toString()),
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 40,
                                            color: _blackWhite
                                          )
                                      ),
                                    )),
                              ),

                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(icon: Icon(Icons.volume_up, color: _blackWhite), onPressed: () async{
                                      await flutterTts.speak(_controller.text.trim().toString());
                                    }),
                                    // IconButton(icon: Icon(Icons.share, color: _blackWhite), onPressed: () {
                                    //   Share.share('${_controller.text} - ${snapshot.data["definitions"][index]["definition"]}, Example: - ${snapshot.data["definitions"][index]["example"]}, Type:- ${snapshot.data["definitions"][index]["type"]}', subject: _controller.text.trim().toString());
                                    // }),
                                    IconButton(icon: Icon(Icons.copy, color: _blackWhite), onPressed: () {
                                      Clipboard.setData(new ClipboardData(text: _controller.text.trim().toString()));
                                      Scaffold.of(context).showSnackBar(new SnackBar(
                                        content: new Text('Copied to Clipboard!', style: GoogleFonts.poppins(),),
                                      ));
                                    }),
                                    _isLiked ? IconButton(icon: Icon(CupertinoIcons.heart_fill, color: Colors.pink,), onPressed: () {
                                      setState(() {
                                        _isLiked = false;
                                      });
                                      _like();
                                    })
                                    :
                                  IconButton(icon: Icon(CupertinoIcons.heart, color: Colors.pink,), onPressed: () {
                                    setState(() {
                                      _isLiked = true;
                                    });
                                    _like();
                                  }
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.amberAccent,
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Text(
                                        'DEFINITION',
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      toBeginningOfSentenceCase(snapshot.data["definitions"][index]["definition"].toString()),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18,
                                              color: _blackWhite
                                          )
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              snapshot.data["definitions"][index]["example"] != null ?
                              Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.amberAccent,
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Text(
                                        'EXAMPLE',
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                    child: Text(
                                      toBeginningOfSentenceCase(snapshot.data["definitions"][index]["example"]),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18,
                                              color: _blackWhite
                                          )
                                      ),
                                    ),
                                  )
                                ],
                              ) :
                              Container()
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
  _listen() async{
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) =>
              setState(() {
                print('val');
              }),
        );
      }
    }
  }
}



