import 'package:fcc_advert_mobile_app/src/config/colors.dart';
import 'package:flutter/material.dart';

class FormLayout extends StatelessWidget {
  final Widget child;
  final String? subtitle;
  final String title;

  const FormLayout({
    super.key,
    required this.child,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Container(
        width: double.infinity,
        height:  double.infinity,
        color: AppColors.primaryBackground,
        padding:  const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400
                  ),
                ),
                if (subtitle != null && subtitle!.isNotEmpty)
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
              ],
            ),
            Expanded(
                child: child
            )
          ],
        ),
      ),
    );
  }
}
