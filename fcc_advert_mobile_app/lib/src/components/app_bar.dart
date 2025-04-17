import 'package:fcc_advert_mobile_app/src/client.dart';
import 'package:fcc_advert_mobile_app/src/components/profile_icon.dart';
import 'package:flutter/material.dart';
import 'package:fcc_advert_mobile_app/src/config/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? isProfile;
  final bool? isTrack;
  const CustomAppBar({
    Key? key,
    this.isProfile = false,
    this.isTrack =false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Material(
        elevation: 6, // 👈 Stronger shadow
        shadowColor: Colors.black12,
        child: AppBar(
          backgroundColor: AppColors.primaryBackground,
          surfaceTintColor: Colors.transparent,
          elevation: 0, // Turn off AppBar’s default elevation
          leading: isProfile! ? CustomProfileIcon(radius: 30) : IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.iconColor),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            if (isTrack!) ...[
              IconButton(
                icon: const Icon(Icons.my_location_rounded, color: AppColors.iconColor),
                onPressed: () async {},
              ),
            ],
            IconButton(
              icon: const Icon(Icons.logout, color: AppColors.iconColor),
              onPressed: () async {
                await apiClient.clearToken();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Logging out.."),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
                Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}