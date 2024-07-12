import 'dart:convert';

class Translation {
  String? sura;
  String? aya; 
  String?arabictext; 
  String? translation;

  Translation({this.sura, this.arabictext, this.aya, this.translation});

  factory Translation.fromJson(Map<String,dynamic> json){
    return Translation(
      sura: json['sura'],
      aya: json['aya'],
      arabictext: json['arabic_text'],
      translation: json['translation']
    );
  }
}