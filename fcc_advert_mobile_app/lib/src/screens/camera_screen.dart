// // import 'dart:io';
// //
// // import 'package:camera/camera.dart';
// // import 'package:flutter/material.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:path/path.dart' as path;
// //
// // class CustomCameraScreen extends StatefulWidget {
// //   static String routename = "/camera";
// //   const CustomCameraScreen({super.key});
// //
// //   @override
// //   State<CustomCameraScreen> createState() => _CustomCameraScreenState();
// // }
// //
// // class _CustomCameraScreenState extends State<CustomCameraScreen> {
// //   late CameraController _controller;
// //   late Future<void> _initializeControllerFuture;
// //   bool _isCameraInitialized = false;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _initializeControllerFuture = _initializeCamera();
// //   }
// //
// //   Future<void> _initializeCamera() async {
// //     final cameras = await availableCameras();
// //     final firstCamera = cameras.firstWhere(
// //           (camera) => camera.lensDirection == CameraLensDirection.back,
// //       orElse: () => cameras.first,
// //     );
// //
// //     _controller = CameraController(
// //       firstCamera,
// //       ResolutionPreset.medium,
// //     );
// //
// //     await _controller.initialize();
// //
// //     if (mounted) {
// //       setState(() {
// //         _isCameraInitialized = true;
// //       });
// //     }
// //   }
// //
// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }
// //
// //   Future<XFile?> _takePicture() async {
// //     if (!_controller.value.isInitialized) {
// //       return null;
// //     }
// //     if (_controller.value.isTakingPicture) {
// //       return null;
// //     }
// //
// //     try {
// //       final XFile file = await _controller.takePicture();
// //       return file;
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Error taking picture: $e')),
// //       );
// //       return null;
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Custom Camera'),
// //         backgroundColor: Colors.black,
// //       ),
// //       body: FutureBuilder<void>(
// //         future: _initializeControllerFuture,
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.done) {
// //             if (_isCameraInitialized) {
// //               return Stack(
// //                 children: [
// //                   CameraPreview(_controller),
// //                   Align(
// //                     alignment: Alignment.bottomCenter,
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(20.0),
// //                       child: ElevatedButton(
// //                         onPressed: () async {
// //                           final XFile? image = await _takePicture();
// //                           if (image != null) {
// //                             Navigator.pop(context, image); // Return the XFile
// //                           }
// //                         },
// //                         style: ElevatedButton.styleFrom(
// //                           shape: const CircleBorder(),
// //                           padding: const EdgeInsets.all(20),
// //                           backgroundColor: Colors.white,
// //                         ),
// //                         child: const Icon(Icons.camera, color: Colors.black),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               );
// //             } else {
// //               return const Center(child: Text('Camera not available'));
// //             }
// //           } else {
// //             return const Center(child: CircularProgressIndicator());
// //           }
// //         },
// //       ),
// //     );
// //   }
// // }
// //
// // // Example of how to use the camera screen
// // void showCamera(BuildContext context) async {
// //   final result = await Navigator.push(
// //     context,
// //     MaterialPageRoute(builder: (context) => const CustomCameraScreen()),
// //   );
// //
// //   if (result is XFile) {
// //     // Handle the captured image
// //     print('Image captured: ${result.path}');
// //     // You can now use the XFile (e.g., save it, upload it, etc.)
// //   }
// // }
//
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
//
// class CameraMan extends StatefulWidget {
//   static String routename = "/camera";
//
//   const CameraMan({super.key});
//
//   @override
//   State<CameraMan> createState() => _CameraManState();
// }
//
// class _CameraManState extends State<CameraMan> {
//   Future<void> _setupCameras() async{
//     List<CameraDescription> _cameras = await availableCameras();
//     if(_cameras.isNotEmpty)
//   }
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
