import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:read_quran/pages/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>   BottomBar() ));
     });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
            color: Colors.green[400],
            ),
          child : Center(
            child: Column(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Lottie.asset('lib/assets/bismillah.json'),
                ),
                SizedBox(
                  width: 300,
                  height: 200,
                  child: Lottie.asset('lib/assets/splashlogo.json'),
                ),
                 SizedBox(
                  height: 50,
                ),
                Text('Read Quran',style: GoogleFonts.abel(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 35
                ),),
                 SizedBox(
                  height: 30,
                ),
                Text('"Read in the name of your Lord who created"',style: GoogleFonts.abel(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15
                ),)
              ],
            ),
          ),),
        ],
      ),
    );
  }
}