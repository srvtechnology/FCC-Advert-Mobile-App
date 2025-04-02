import 'package:fcc_advert_mobile_app/src/screens/advertisement_list_screen.dart';
import 'package:fcc_advert_mobile_app/src/screens/login_screen.dart';
import 'package:fcc_advert_mobile_app/src/screens/otp_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routename,
      routes: {
        LoginScreen.routename: (context)=>LoginScreen(),
        AdvertisementListPage.routename : (context)=>AdvertisementListPage(),
        OTPScreen.routename : (context)=>OTPScreen()
      }
    );
  }
}