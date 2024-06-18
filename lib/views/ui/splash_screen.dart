import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movieapp/common/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //time variable declaration
  Timer? timer;

  //call initState
  @override
  void initState() {
    super.initState();
    timer = Timer(
      const Duration(seconds: 5),
      () => Navigator.pushReplacementNamed(context, '/bottomnav'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MovieAppColor.splashBgColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .5,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/Rectangle.png'),
                  ),
                ),
              ),
              //space
              const SizedBox(height: 10),
              //text
              Container(
                width: 200,
                height: 20,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Moviemot.png')
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
