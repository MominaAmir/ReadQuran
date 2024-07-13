import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read_quran/model/constaant.dart';
import 'package:read_quran/model/juzModel..dart';
import 'package:http/http.dart' as http;
import 'package:read_quran/model/sajdaModel.dart';

class SajdaScreen extends StatelessWidget {
  static const String id = 'juz';
  const SajdaScreen({super.key});

  Future<SajdaModel> getSajda(int index)async{
    
  String sajdaendpoint = 'https://api.alquran.cloud/v1/sajda/quran-uthmani ';
  final res = await http.get(Uri.parse(sajdaendpoint));
  if(res.statusCode == 200){
    return SajdaModel.fromJSON(json.decode(res.body));
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
          title: Text('Sajda', style: GoogleFonts.acme(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
          backgroundColor: Colors.green,
        ),
        body: FutureBuilder(
          future: getSajda(Constants.sajdaIndex!), 
          builder: (context, AsyncSnapshot<SajdaModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            } else if(snapshot.hasData){
              print('${snapshot.data!.sajdaAyahs.length} length');
              return ListView.builder(
                itemCount: snapshot.data!.sajdaAyahs.length,
                itemBuilder: (context, index){
                  return CustomListTileSajda(index: index, list: snapshot.data!.sajdaAyahs);
                });
            }
            else{
              return Center(child: Text("Data not found"),);
            }
          }),
    ));
  }
}