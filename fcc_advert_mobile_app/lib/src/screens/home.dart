// import 'package:fcc_advert_mobile_app/src/screens/camera_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:camera/camera.dart';
//
// class HomeScreen extends StatelessWidget {
//   static String routename = "/home";
//   const HomeScreen({super.key});
//
//   Future<void> openCamera(BuildContext context) async {
//     final status = await Permission.camera.request();
//
//     if (status.isGranted) {
//       final result = await Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const CustomCameraScreen()),
//       );
//
//       if (result is XFile) {
//         debugPrint("Captured Image Path: ${result.path}");
//         // handle image here
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Camera permission denied")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Home")),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => openCamera(context),
//           child: const Text("Open Camera"),
//         ),
//       ),
//     );
//   }
// }
