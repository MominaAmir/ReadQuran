// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Surah{
  int? number;
  String? name;
  String? englishname;
  String? englishNameTranslation;
  int? numberofayat;
  String? revelationtype;

  Surah({this.number, this.name, this.englishname, this.englishNameTranslation, this.numberofayat, this.revelationtype});


  factory Surah.fromJson(Map<String, dynamic> json){
    return Surah(
      number: json['number'],
      name: json['name'],
      englishname: json['englishname'],
      englishNameTranslation: json['englishNameTranslation'],
      numberofayat: json['numberofayat'],
      revelationtype: json['revelationtype']  
    );
  }
}
Widget SurahCustomListTile({
  required Surah surah, 
  required BuildContext context, 
  required VoidCallback onTap
})
{
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3.0
          )
        ]
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: 60,
                height: 50,
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightGreen,
                ),
                child: Text((surah.number ?? '').toString(), 
                style: const TextStyle(color: Colors.white, fontSize: 16 , fontWeight: FontWeight.bold),),
              ),
              const SizedBox(width: 20,),
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(surah.englishname ?? '', style:GoogleFonts.anticDidone(fontWeight: FontWeight.bold),),
                  Text(surah.englishNameTranslation ?? '',style: GoogleFonts.charisSil(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
                ],
              ),
              const Spacer(),
              Text(surah.name ?? '', style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),),
            ],
          )
        ],
      ),
    ),
  );
}