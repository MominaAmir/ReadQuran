import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:read_quran/model/constaant.dart';
import 'package:read_quran/model/juzModel..dart';
import 'package:http/http.dart' as http;
import 'package:read_quran/model/sajdaModel.dart';
import 'package:read_quran/model/surahlist.dart';
import 'package:read_quran/pages/juz.dart';
import 'package:read_quran/pages/juzTranslation.dart';
import 'package:read_quran/pages/surahTranslation.dart';


class Translation extends StatefulWidget {
  const Translation({Key? key}) : super(key: key);

  @override
  State<Translation> createState() => _TranslationState();
}

class _TranslationState extends State<Translation> {

   final surahEndPoint = 'http://api.alquran.cloud/v1/surah';
  List<Surah> list = [];

  Future<List<Surah>> getSurah() async {
    Response res = await http.get(Uri.parse(surahEndPoint));
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      json['data'].forEach((element) {
        if (list.length < 114) {
          list.add(Surah.fromJson(element));
        }
      });
      print('ol ${list.length}');
      return list;
    } else {
      throw ("Cannot get te surah");
    }
  }

  Future<SajdaModel> getSajda() async {
    String sajdaendpoint = 'http://api.alquran.cloud/v1/sajda/en.asad';
    final res = await http.get(Uri.parse(sajdaendpoint));
    if (res.statusCode == 200) {
      return SajdaModel.fromJSON(json.decode(res.body));
    } else {
      throw ("failed to load data");
    }
  }


  @override
  Widget build(BuildContext context) {
     return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text(
                'Translation',
                style: GoogleFonts.acme(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              bottom: TabBar(tabs: [
                Text("Surah",
                    style: GoogleFonts.acme(fontSize: 20, color: Colors.black)),
                Text("Juz",
                    style: GoogleFonts.acme(fontSize: 20, color: Colors.black)),
               Text("Sajda",
                    style: GoogleFonts.acme(fontSize: 20, color: Colors.black)),
               ]),
            ),
            body: TabBarView(children: <Widget>[
              FutureBuilder(
                  future: getSurah(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Surah>> snapshot) {
                    if (snapshot.hasData) {
                      List<Surah>? surah = snapshot.data;
                      return ListView.builder(
                        itemCount: surah!.length,
                        itemBuilder: (context, index) => SurahCustomListTile(
                            surah: surah[index],
                            context: context,
                            onTap: () {
                               setState(() {
                            Constants.SurahIndex = (index + 1);
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SurahTranslationPage()),
                          );
                            }),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: ListView.builder(
                    itemCount: 30,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            Constants.juzIndex = (index + 1);
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const JuzTranslationPage()),
                          );
                        },
                        child: Card(
                          elevation: 4,
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          color: Colors.lightGreen,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    'Juz  ${index + 1}',
                                    style: GoogleFonts.acme(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              FutureBuilder(
                  future: getSajda(),
                  builder: (context, AsyncSnapshot<SajdaModel> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      print('${snapshot.data!.sajdaAyahs.length} length');
                      return ListView.builder(
                          itemCount: snapshot.data!.sajdaAyahs.length,
                          itemBuilder: (context, index) {
                            return CustomListTileSajda(
                                index: index, list: snapshot.data!.sajdaAyahs);
                          });
                    } else {
                      return Center(
                        child: Text("Data not found"),
                      );
                    }
                  }),

            ])),
      ),
    );

  }
}
