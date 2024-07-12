import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read_quran/model/constaant.dart';
import 'package:read_quran/model/juzModel..dart';
import 'package:http/http.dart' as http;

class JuzScreen extends StatelessWidget {
  static const String id = 'juz';
  const JuzScreen({super.key});

  Future<JuzModel> getJuzz(int index)async{
    
  String juzendpoint = 'http://api.alquran.cloud/v1/juz/$index/quran-uthmani ';
  final res = await http.get(Uri.parse(juzendpoint));
  if(res.statusCode == 200){
    return JuzModel.fromJSON(json.decode(res.body));
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
          title: Text('Juz', style: GoogleFonts.acme(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),
          backgroundColor: Colors.green,
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
                  return CustomListTileJuz(index: index, list: snapshot.data!.juzayahs);
                });
            }
            else{
              return Center(child: Text("Data not found"),);
            }
          }),
    ));
  }
}