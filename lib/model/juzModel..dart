import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read_quran/pages/quran.dart';

class JuzAyahs {
  final String ayahsText;
  final int  ayahsNumber; 
  final String surahName;

  JuzAyahs({required this.ayahsText, required this.ayahsNumber, required this.surahName});

  factory JuzAyahs.fromJSON(Map<String, dynamic> json) {
    return JuzAyahs(
      ayahsText: json['text'], 
      ayahsNumber: json['number'], 
      surahName: json['surah']['name']);
  }
}

class JuzModel {
  final int? juzNumber;
  final List<JuzAyahs> juzayahs;

  JuzModel({required this.juzNumber, required this.juzayahs});

   factory JuzModel.fromJSON(Map<String, dynamic> json) {
    Iterable juzayahs = json['data']['ayahs'];
    List<JuzAyahs> juzAyahsList = juzayahs.map((e) => JuzAyahs.fromJSON(e)).toList();
    return JuzModel(
      juzNumber: json['data']['number'], 
      juzayahs: juzAyahsList, );
  }
}


class CustomListTileJuz extends StatelessWidget {
  final double fontsize;
  final int index;
  final List<JuzAyahs> list;
  const CustomListTileJuz({super.key, required this.index, required this.list , required this.fontsize});

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
                    Text(list[index].ayahsNumber.toString() ?? '', style:GoogleFonts.anticDidone(fontWeight: FontWeight.bold),),
                    Text(list[index].ayahsText ?? '',
                    style: GoogleFonts.charisSil(color: Colors.black, fontWeight: FontWeight.w700, fontSize: fontsize, ),
                    textAlign: TextAlign.end,),
                    Text(list[index].surahName ?? '',
                    textAlign: TextAlign.end,),
                  ],
                ),
        );
    
  }
}



class CustomListTileJuzTranslation extends StatelessWidget {
  final int index;
  final double fontSize;
  final List<JuzAyahs> list;
  const CustomListTileJuzTranslation({super.key, required this.index, required this.list, required this.fontSize});

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(list[index].ayahsNumber.toString() ?? '', style:GoogleFonts.anticDidone(fontWeight: FontWeight.bold),),
                    Text(list[index].ayahsText ?? '',
                    style: GoogleFonts.charisSil(color: Colors.black, fontWeight: FontWeight.w700, fontSize: fontSize, ),
                    textAlign: TextAlign.start,),
                    Text(list[index].surahName ?? '',
                    textAlign: TextAlign.end,),
                  ],
                ),
        );
    
  }
}