import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read_quran/model/constaant.dart';
import 'package:read_quran/model/juzModel..dart';
import 'package:http/http.dart' as http;
import 'package:read_quran/model/surahModel.dart';

class SurahTranslationPage extends StatefulWidget {
  static const String id = 'juz';
  const SurahTranslationPage({super.key});

  @override
  State<SurahTranslationPage> createState() => _SurahTranslationPageState();
}

class _SurahTranslationPageState extends State<SurahTranslationPage> {
  Future<SurahModel> getSurahTranslation(int index)async{
    
  String surahendpoint = 'https://api.alquran.cloud/v1/surah/$index/en.asad';
  final res = await http.get(Uri.parse(surahendpoint));
  if(res.statusCode == 200){
    return SurahModel.fromJSON(json.decode(res.body));
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
          title: Text('Surahs', style: GoogleFonts.acme(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
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
          future: getSurahTranslation(Constants.SurahIndex!), 
          builder: (context, AsyncSnapshot<SurahModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            } else if(snapshot.hasData){
              print('${snapshot.data!.surahModel.length} length');
              return ListView.builder(
                itemCount: snapshot.data!.surahModel.length,
                itemBuilder: (context, index){
                  return CustomListTileSurah(index: index, list: snapshot.data!.surahModel, fontsize: _fontSize,);
                });
            }
            else{
              return Center(child: Text("Data not found"),);
            }
          }),
    ));
  }
}