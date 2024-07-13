import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read_quran/pages/quran.dart';


class SajdaAyahs {
  final String ayahsText;
  final int  ayahsNumber; 
  final String surahName;
  final int sajdaNumber;
  final int juzNumber;

  SajdaAyahs({required this.ayahsText, required this.ayahsNumber, required this.surahName, required this.sajdaNumber, required this.juzNumber});

  factory SajdaAyahs.fromJSON(Map<String, dynamic> json) {
    return SajdaAyahs(
      ayahsText: json['text'], 
      ayahsNumber: json['number'], 
      surahName: json['surah']['name'],
      sajdaNumber: json['sajda']['id'],
      juzNumber: json['juz']);
  }
}

class SajdaModel {
  final List<SajdaAyahs> sajdaAyahs;

  SajdaModel({required this.sajdaAyahs});

   factory SajdaModel.fromJSON(Map<String, dynamic> json) {
    Iterable sajdaAyahs = json['data']['ayahs'];
    List<SajdaAyahs> sajdaAyahsList = sajdaAyahs.map((e) => SajdaAyahs.fromJSON(e)).toList();
    return SajdaModel(
      sajdaAyahs: sajdaAyahsList, );
  }
}


class CustomListTileSajda extends StatelessWidget {
  final int index;
  final List<SajdaAyahs> list;
  const CustomListTileSajda({super.key, required this.index, required this.list});
  
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
                    Text('Sajda No: '+ list[index].sajdaNumber.toString() ?? '',style:TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,),
                     Text('Juz No: '+ list[index].juzNumber.toString() ?? '',style:TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,),
                    Text(list[index].ayahsNumber.toString() ?? '', style:GoogleFonts.anticDidone(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,),
                    Text(list[index].ayahsText ?? '',
                    style: GoogleFonts.charisSil(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20, ),
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
  final List<SajdaAyahs> list;
  const CustomListTileJuzTranslation({super.key, required this.index, required this.list});

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
                    style: GoogleFonts.charisSil(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20, ),
                    textAlign: TextAlign.start,),
                    Text(list[index].surahName ?? '',
                    textAlign: TextAlign.end,),
                  ],
                ),
        );
    
  }
}