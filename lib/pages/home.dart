import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:read_quran/model/ayatModel.dart';
import 'package:http/http.dart' as http;
import 'package:read_quran/pages/quran.dart';
import 'package:read_quran/pages/page2.dart';
import 'package:read_quran/pages/prayer.dart';
import 'package:hijri/hijri_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Ayatmodel> futureAyat;

  @override
  void initState() {
    super.initState();
    futureAyat = getayaoftheday();
  }
Future<Ayatmodel> getayaoftheday() async {
  String url =
      "https://api.alquran.cloud/v1/ayah/${random(1, 6237)}/editions/quran-uthmani,en.asad,en.pickthall";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);
    print("Response data: $jsonData"); // Debug print
    if (jsonData['data'] != null && jsonData['data'].isNotEmpty) {
      List<dynamic> data = jsonData['data'];
      return Ayatmodel.fromJSON(data);
    } else {
      throw Exception("No data found in the response");
    }
  } else {
    throw Exception("Failed to load ayat");
  }
}
  int random(int min, int max) {
    var rn = Random();
    return min + rn.nextInt(max - min);
  }

  @override
  Widget build(BuildContext context) {
    HijriCalendar.setLocal('ar');
    var hijri = HijriCalendar.now();
    var day = DateTime.now();
    var format = DateFormat('EEE, d MMM yyyy');
    var formatted = format.format(day);
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: size.height * 0.32,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("lib/assets/home.jpeg"),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatted,
                    style: GoogleFonts.acme(color: Colors.white, fontSize: 20),
                  ),
                  RichText(
                    text: TextSpan(
                      children: <InlineSpan>[
                        WidgetSpan(
                          style:  GoogleFonts.acme(fontSize: 20.0),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              hijri.hDay.toString(),
                              style:  GoogleFonts.acme(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        WidgetSpan(
                          style:  GoogleFonts.acme(fontSize: 20.0),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              hijri.longMonthName.toString(),
                              style:  GoogleFonts.acme(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        WidgetSpan(
                          style:  GoogleFonts.acme(fontSize: 20.0),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              '${hijri.hYear} AH',
                              style: GoogleFonts.acme(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Column(
                  children: [
                    FutureBuilder<Ayatmodel>(
                      future: futureAyat,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting ||
                            snapshot.connectionState == ConnectionState.active) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          print("Error: ${snapshot.error}"); // Debug print
                          return const Icon(Icons.sync_problem);
                        } else if (snapshot.hasData) {
                          var data = snapshot.data!;
                          return Container(
                            margin: const EdgeInsets.all(16),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: Colors.lightGreen,
                              boxShadow: [
                                const BoxShadow(
                                  blurRadius: 3,
                                  spreadRadius: 1,
                                  offset: Offset(0, 1),
                                )
                              ]
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Quran Ayat Of The Day",
                                  style: GoogleFonts.acme(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Divider(
                                  color: Colors.black,
                                  thickness: 0.5,
                                ),
                                Text(
                                  data.arText ?? '',
                                  style: GoogleFonts.acme(color: Colors.black54),
                                ),
                                Text(
                                  data.ayatrans ?? '',
                                  style: GoogleFonts.acme(color: Colors.black54),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: <InlineSpan>[
                                      WidgetSpan(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            data.suNum.toString(),
                                          ),
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(data.suName ?? ''),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return const Icon(Icons.sync_problem);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedindex = 0;
  final List<Widget> _widget = [const HomePage(), const Quranpage(), const PageTwo(), const Prayers()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widget[selectedindex],
      bottomNavigationBar: ConvexAppBar(
        items: [
          const TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Image.asset("lib/assets/quran.png"), title: 'Quran'),
          const TabItem(icon: Icons.audiotrack, title: 'Audio'),
          const TabItem(icon: Icons.mosque, title: 'Prayer'),
        ],
        onTap: updateIndex,
        backgroundColor: Colors.green,
      ),
    );
  }

  void updateIndex(index) {
    setState(() {
      selectedindex = index;
    });
  }
}
