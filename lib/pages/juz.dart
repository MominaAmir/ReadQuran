import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:read_quran/model/bookmarkModel.dart';
import 'package:read_quran/model/constaant.dart';
import 'package:read_quran/model/juzModel..dart';
import 'package:http/http.dart' as http;
import 'package:read_quran/provider.dart/bookmarkProvider.dart';

class JuzScreen extends StatefulWidget {
  static const String id = 'juz';
  const JuzScreen({super.key});

  @override
  State<JuzScreen> createState() => _JuzScreenState();
}

class _JuzScreenState extends State<JuzScreen> {
  Future<JuzModel> getJuzz(int index)async{
  String juzendpoint = 'http://api.alquran.cloud/v1/juz/$index/quran-uthmani ';
  final res = await http.get(Uri.parse(juzendpoint));
  if(res.statusCode == 200){
    return JuzModel.fromJSON(json.decode(res.body));
  }else{
    throw("failed to load data");
  }
  }

  double _fontSize = 16.0;

  void _increaseFontSize() {
    setState(() {
      _fontSize += 2;
    });
  }

  void _decreaseFontSize() {
    setState(() {
      _fontSize -= 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Juz', style: GoogleFonts.acme(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
          backgroundColor: Colors.green,
           actions: [
          IconButton(
            icon: Icon(Icons.zoom_in),
            onPressed: _increaseFontSize,
          ),
          IconButton(
            icon: Icon(Icons.zoom_out),
            onPressed: _decreaseFontSize,
          ),
           
        ],
        ),
        body: FutureBuilder(
          future: getJuzz(Constants.juzIndex!), 
          builder: (context, AsyncSnapshot<JuzModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            } else if(snapshot.hasData){
              print('${snapshot.data!.juzayahs.length} length');
              return ListView.builder(
                itemCount: snapshot.data!.juzayahs.length,
                itemBuilder: (context, index){
                  return CustomListTileJuz(index: index, list: snapshot.data!.juzayahs, fontsize: _fontSize);
                });
            }
            else{
              return Center(child: Text("Data not found"),);
            }
          }),
    ));
  }
}