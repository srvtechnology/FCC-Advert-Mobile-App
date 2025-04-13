import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomProfileIcon extends StatelessWidget {
  final double radius;

  const CustomProfileIcon({super.key, this.radius = 40});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, "/profile");
      },
      child: Center(
        child: SvgPicture.asset(
          'assets/profile_icon.svg',
          width: radius *0.6, // scale SVG within the circle
          height: radius*0.6,
          colorFilter: const ColorFilter.mode(
            Color(0xFF5E3FAD), // Icon color (dark purple)
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
