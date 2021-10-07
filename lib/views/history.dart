import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String _collection;

  Color _backgroundColor = Colors.grey[50];
  Color _blackWhite = Colors.grey[50];
  Color _greyWhite = Colors.white;
  Color _greyDark = Colors.grey[300];
  Color _appBar = Colors.red;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCollection();
    print("data");
    _initDarkResolve();
  }
  _initDarkResolve() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('dark')){
      setState(() {
        _backgroundColor = Colors.grey[900];
        _blackWhite = Colors.white;
        _greyWhite = Colors.grey[100];
        _appBar = Colors.red[700];

      });
    }
    if(prefs.getBool('dark') == false){
      setState(() {
        _backgroundColor = Colors.grey[50];
        _blackWhite = Colors.black;
        _greyWhite = Colors.grey;
        _appBar = Colors.red;
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
        backgroundColor: _appBar,
        elevation: 0,
        title: Text(
          "History",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600
              )
          ),
        ),
      ),
      body: Container(
        child: PaginateFirestore(
          //item builder type is compulsory.
          itemBuilder: (index, context, documentSnapshot) {
            final data = documentSnapshot.data() as Map;
            data['id'] = documentSnapshot.id;
            return ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: data == null ? Column(
                children: [
                  Image.asset('assets/history.png'),
                  Text('No History Found!', style: GoogleFonts.poppins(color: Colors.redAccent, fontSize: 18),)
                ],
              ) : ListTile(
                title: Text(
                  '${toBeginningOfSentenceCase('${data['search']}')}',
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
                              FirebaseFirestore.instance.collection(_collection).doc('history').collection('history').doc(data['id']).update({
                                'deleted': true
                              });
                              Navigator.pop(context);
                            },
                            child: Text("Confirm", style: GoogleFonts.poppins(),),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
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
              ),);
          },
          // orderBy is compulsory to enable pagination
          query: FirebaseFirestore.instance.collection('$_collection').doc('history').collection('history').orderBy('time'),
          //Change types accordingly
          itemBuilderType: PaginateBuilderType.listView,
          // to fetch real-time data
          isLive: true,
        ),

      ),
    );
  }
}
