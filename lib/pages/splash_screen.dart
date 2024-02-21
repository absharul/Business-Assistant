import 'dart:async';
import 'package:flutter/material.dart';
import 'package:form_app/constants/color.dart';
import 'package:form_app/pages/formpage.dart';
import 'package:form_app/pages/homepage.dart';
import 'package:form_app/pages/tabs/homemain.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay and then navigate to the main screen
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeMain()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: const Center(
        child: Column(
          children: [
            SizedBox(height: 200.0,),
            Image(image: AssetImage('asset/catlogo.png'),width: 300, height: 300,),
            SizedBox(height: 15.0,),
            Text("Assistant for Business",style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),)
          ],
        )
        ),
    );
  }
}
