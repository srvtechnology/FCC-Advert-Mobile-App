import 'dart:async';
import 'package:fcc_advert_mobile_app/src/client.dart';
import 'package:fcc_advert_mobile_app/src/config/colors.dart';
import 'package:fcc_advert_mobile_app/src/screens/login_screen.dart';
import 'package:fcc_advert_mobile_app/src/screens/main.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static String routename = "/splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isTrue = false;
  @override
  void initState(){
    super.initState();
    route();
  }
  startTime() async {
    var duration = new Duration(seconds: 6);
    return new Timer(duration, route);
  }
  route() {
    setState(() {
      _isTrue=true;
    });
    apiClient.isToken().then((value)=>{
      if (value){
        Navigator.pushNamed(context, AdvertisementListPage.routename)
      }else{
        Navigator.pushNamed(context, LoginScreen.routename)
    }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isTrue?Center(
        child: CircularProgressIndicator(
          color: AppColors.iconColor,
        ),
      ):Container()
    );
  }
}
