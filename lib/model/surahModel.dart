import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read_quran/pages/quran.dart';

class SurahAyahs {
  final String ayahsText;
  final int  ayahsNumber; 


  SurahAyahs({required this.ayahsText, required this.ayahsNumber,});

  factory SurahAyahs.fromJSON(Map<String, dynamic> json) {
    return SurahAyahs(
      ayahsText: json['text'], 
      ayahsNumber: json['number'],);
  }
}

class SurahModel {
  final int? surahNumber;
  final List<SurahAyahs> surahModel;

  SurahModel({required this.surahNumber, required this.surahModel});

   factory SurahModel.fromJSON(Map<String, dynamic> json) {
    Iterable surahayahs = json['data']['ayahs'];
    List<SurahAyahs> surahAyahList = surahayahs.map((e) => SurahAyahs.fromJSON(e)).toList();
    return SurahModel(
      surahNumber: json['data']['number'], 
      surahModel: surahAyahList, );
  }
}

class CustomListTileSurah extends StatelessWidget {
  final int index;
  final List<SurahAyahs> list;
  const CustomListTileSurah({super.key, required this.index, required this.list});

  @override
  Widget build(BuildContext context) {
    return Container( 
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 165, 243, 149),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3.0
            )
          ]
        ),
        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(list[index].ayahsNumber?.toString() ?? '', style:GoogleFonts.anticDidone(fontWeight: FontWeight.bold),),
                    Text(list[index].ayahsText ?? '',
                    style: GoogleFonts.charisSil(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20, ),
                    textAlign: TextAlign.end,),
                   
                  ],
                ),
        );
    
  }
}