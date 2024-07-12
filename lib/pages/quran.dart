import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:read_quran/model/constaant.dart';
import 'package:read_quran/model/surah.dart';
import 'package:read_quran/pages/juz.dart';
import 'package:read_quran/pages/surah.dart';

class Quranpage extends StatefulWidget {
  const Quranpage({Key? key}) : super(key: key);

  @override
  State<Quranpage> createState() => _QuranpageState();
}

class _QuranpageState extends State<Quranpage> {
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
                'Quran',
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
                                builder: (context) => const SurahScreen()),
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
                                builder: (context) => const JuzScreen()),
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
              const Center(
                child: Text("Hello"),
              )
            ])),
      ),
    );
  }
}
