import 'package:app_scrip_assignment/Pages/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      Get.offAll(OnboardingScreen());
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipRRect(child: Image.asset("assets/images/appscrip_logo.jpeg"), borderRadius: BorderRadius.circular(300),),
      ),
    );
  }
}