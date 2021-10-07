import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Like extends StatefulWidget {
  @override
  _LikeState createState() => _LikeState();
}
int _random = 0;
class RandomImage extends StatelessWidget {
  final int random;
  RandomImage({this.random});

  @override
  Widget build(BuildContext context) {
   if(random == 0){
      return Center(child: Image.asset('assets/like.png'));
    }if(random == 1){
      return Center(child: Lottie.asset('assets/like/1.json', repeat: true, animate: true, width: MediaQuery.of(context).size.width/1.1, height: MediaQuery.of(context).size.width/1.1));
    }if(random == 2){
      return Center(child: Lottie.asset('assets/like/2.json', repeat: true, animate: true, width: MediaQuery.of(context).size.width/1.1, height: MediaQuery.of(context).size.width/1.1));
    }if(random == 3){
      return Center(child: Lottie.asset('assets/like/3.json', repeat: true, animate: true, width: MediaQuery.of(context).size.width/1.1, height: MediaQuery.of(context).size.width/1.1));
    }if(random == 4){
      return Center(child: Lottie.asset('assets/like/4.json', repeat: true, animate: true, width: MediaQuery.of(context).size.width/1.1, height: MediaQuery.of(context).size.width/1.1));
    }
  }
}

class _LikeState extends State<Like> {
  Color _backgroundColor = Colors.grey[50];
  Color _blackWhite = Colors.grey[50];
  Color _greyWhite = Colors.white;
  Color _greyDark = Colors.grey[300];
  Color _appBar = Colors.red;

  String _collection;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCollection();
    print("data");
    _initDarkResolve();
    var rng = new Random();
    setState(() {
      _random = rng.nextInt(5);
      print(_random);
    });
  }
  _initDarkResolve() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('${prefs.getBool('dark')} is the pref stats');
    bool val = prefs.getBool('dark');
    if(val){

      print('hey there! the value here is true and 1 is being executed');
      setState(() {
        _backgroundColor = Colors.grey[900];
        _blackWhite = Colors.white;
        _greyWhite = Colors.grey[100];
        _appBar = Colors.red[700];
      });
    }
    if(val == false){
      print('hey there! the value here is true and 1 is being executed');

      setState(() {
        _backgroundColor = Colors.grey[50];
        _blackWhite = Colors.black;
        _greyWhite = Colors.grey;
        _appBar = Colors.red;
      });
    }
    if(val == null){
      print('hey there! the value here is true and 1 is being executed');

      setState(() {
        _backgroundColor = Colors.grey[50];
        _blackWhite = Colors.black;
        _greyWhite = Colors.grey;
        _appBar = Colors.red;
        print(_blackWhite);
        print('${prefs.getBool('dark')} is the status {FIX}');
      });
    }

  }


  getCollection() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _collection = prefs.getString('collection');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        backgroundColor: _appBar,
        elevation: 0,
        title: Text(
          "Liked Words",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
              )
          ),
        ),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('$_collection').doc('like').collection('like').where('deleted', isEqualTo: false).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return  Column(
                children: [
                  Image.asset('assets/error.png'),
                  Text('An Error Occurred!', style: GoogleFonts.poppins(color: Colors.redAccent, fontSize: 18),)
                ],
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return snapshot.data.docs.length == 0 ?
            SingleChildScrollView(
              child: Column(
                children: [
                  RandomImage(random: _random,),
                  Text(
                    'No Liked words found!',
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontSize: 25
                    ),
                  )
                ],
              ),
            ) : ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                data['id'] = document.id;
                print(data);
                return ListTile(
                  title: Text(
                    '${toBeginningOfSentenceCase('${data['word']}')}',
                    style: GoogleFonts.poppins(color: _blackWhite),
                  ),
                  subtitle: Text(
                    '${toBeginningOfSentenceCase('${data['date']} at ${data['time']}')}',
                    style: GoogleFonts.poppins(color: _greyWhite),
                  ),
                  trailing: GestureDetector(
                    onTap: (){
                      return showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          backgroundColor: _backgroundColor,
                          title: Text("Are you sure?", style: GoogleFonts.poppins(color: Colors.redAccent),),
                          content: Text("Do you really want to delete the history", style: GoogleFonts.poppins(color: _blackWhite),),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                FirebaseFirestore.instance.collection(_collection).doc('like').collection('like').doc(data['id']).update({
                                  'deleted': true
                                }).then((value) {
                                  Navigator.pop(context);
                                });
                              },
                              child: Text("Confirm", style: GoogleFonts.poppins(),),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Text("Cancel", style: GoogleFonts.poppins(color: _blackWhite),),
                            ),

                          ],
                        ),
                      );
                    },
                    child: Icon(
                      Icons.delete,
                      color: _appBar,
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
