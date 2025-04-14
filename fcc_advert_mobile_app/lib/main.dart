import 'package:fcc_advert_mobile_app/src/screens/advertisement_detail_screen.dart';
import 'package:fcc_advert_mobile_app/src/screens/camera_screen.dart';
import 'package:fcc_advert_mobile_app/src/screens/home.dart';
import 'package:fcc_advert_mobile_app/src/screens/main.dart';
import 'package:fcc_advert_mobile_app/src/screens/login_screen.dart';
import 'package:fcc_advert_mobile_app/src/screens/multi_form.dart';
import 'package:fcc_advert_mobile_app/src/screens/otp_screen.dart';
import 'package:fcc_advert_mobile_app/src/screens/profile_screen.dart';
import 'package:fcc_advert_mobile_app/src/screens/splash_screen.dart';
import 'package:fcc_advert_mobile_app/src/storage.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await localStorageService.init(); // Important
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,

        debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routename,
      routes: {
          ProfileScreen.routename: (context)=> ProfileScreen(),
          LoginScreen.routename: (context)=>LoginScreen(),
          AdvertisementListPage.routename : (context)=>AdvertisementListPage(),
          OTPScreen.routename : (context)=>OTPScreen(),
          MultiForm.routename : (context)=>MultiForm(),
          AdvertisementListPage.routename : (context)=>AdvertisementListPage(),
          SplashScreen.routename : (context)=>SplashScreen()
          // CustomCameraScreen.routename : (context)=>CustomCameraScreen(),
      }
    );
  }
}

// list page
// individual detail page
// camera component + ai service
// account page