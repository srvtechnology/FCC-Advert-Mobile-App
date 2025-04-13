import 'package:fcc_advert_mobile_app/src/client.dart';
import 'package:fcc_advert_mobile_app/src/components/app_bar.dart';
import 'package:fcc_advert_mobile_app/src/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  static String routename = "/profile";
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final double radius = 100;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: AppColors.primaryBackground,
      body: FutureBuilder(
        future: apiClient.getProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!["user"];
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: radius,
                  backgroundColor: Color(0xFFEDE4FF),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/profile_icon.svg',
                      width: radius, // scale SVG within the circle
                      height: radius,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF5E3FAD), // Icon color (dark purple)
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  data['name'] ?? 'No Name',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Card(
                  color: AppColors.cardColor,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email - ${data['email'] ?? 'No Email'}',
                            style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 10),
                        Text('User type - ${data['userType'] ?? 'System User'}',
                            style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 10),
                        Text(
                          'Note:',
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                        Text(
                          "Please contact your administrator to change email or password.",
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Container(); // Default case (should not reach here)
        },
      ),
    );
  }
}