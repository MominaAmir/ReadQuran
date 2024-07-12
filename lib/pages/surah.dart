import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read_quran/model/constaant.dart';
import 'package:read_quran/model/juzModel..dart';
import 'package:http/http.dart' as http;
import 'package:read_quran/model/surahModel.dart';

class SurahScreen extends StatelessWidget {
  static const String id = 'juz';
  const SurahScreen({super.key});

  Future<SurahModel> getSurah(int index)async{
    
  String surahendpoint = 'https://api.alquran.cloud/v1/surah/$index';
  final res = await http.get(Uri.parse(surahendpoint));
  if(res.statusCode == 200){
    return SurahModel.fromJSON(json.decode(res.body));
  }else{
    throw("failed to load data");
  }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Surahs', style: GoogleFonts.acme(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),
          backgroundColor: Colors.green,
        ),
        body: FutureBuilder(
          future: getSurah(Constants.SurahIndex!), 
          builder: (context, AsyncSnapshot<SurahModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            } else if(snapshot.hasData){
              print('${snapshot.data!.surahModel.length} length');
              return ListView.builder(
                itemCount: snapshot.data!.surahModel.length,
                itemBuilder: (context, index){
                  return CustomListTileSurah(index: index, list: snapshot.data!.surahModel);
                });
            }
            else{
              return Center(child: Text("Data not found"),);
            }
          }),
    ));
  }
}