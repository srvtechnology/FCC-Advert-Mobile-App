import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class Camera extends StatefulWidget {
  final void Function(dynamic)? onChange;
  const Camera({
    Key? key,
    required this.onChange
  }) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  List<CameraDescription>? cameras ;
  CameraController? controller;
  bool _isCameraInitialized =false;
  XFile? pictureFile;
  FlashMode? _currentFlashMode;
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> getPicture(BuildContext context)async{
    try{
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      return image;
    }catch(e){
      print(e);
    }
  }

  Future<XFile?> takePicture(BuildContext context) async {
    final CameraController? cameraController = controller;
    if (cameraController!.value.isTakingPicture) {
      return null;
    }
    try {
      final XFile file = await cameraController.takePicture();
      widget.onChange?.call(file);
      Navigator.pop(
          context, file); // <-- return the XFile to the previous screen
      return file;
    } catch (e) {
      print('Error occurred while taking picture: $e');
      return null;
    }
  }

  void startCamera()async{
    cameras = await availableCameras();
    controller = CameraController(cameras![0], ResolutionPreset.high,enableAudio: false);
    await controller!.initialize().then((value){
      if(!mounted){
        return;
      }setState(() {
        _isCameraInitialized=true;
      });
    }).catchError((e){print(e);});
  }

  @override
  void initState() {
    super.initState();
    startCamera();


  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (!_isCameraInitialized) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              height: height,
              width: width,
              child: CameraPreview(controller!),

            ),
          ),
          Positioned(
            top: height*0.025,
            left: width*0.02,
            child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
          ),
          Positioned(
              top: height*0.85,
              child:Container(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        child: Container(
                          child: IconButton(
                              onPressed: ()async{
                                await getPicture(context);
                              },
                              icon: Icon(Icons.camera_alt)
                          ),
                        )
                    ),
                    Expanded(
                      child: Container(
                        width: 70,
                        height: 70,
                        child: FittedBox(
                          child: FloatingActionButton(
                            backgroundColor: Colors.white,
                            onPressed: ()async{
                              await takePicture(context);
                            },child: Icon(Icons.camera_alt_outlined,color: Colors.black,size: 25,),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child:Container(
                        child: InkWell(
                          onTap: () async{
                            if(_currentFlashMode == FlashMode.off){
                              await controller!.setFlashMode(
                                FlashMode.torch,
                              );
                              setState((){
                                _currentFlashMode=FlashMode.torch;
                              });
                            }
                            else{
                              await controller!.setFlashMode(
                                FlashMode.off,
                              );
                              setState(() {
                                _currentFlashMode = FlashMode.off;
                              });

                            }
                          }

                          ,
                          child: Icon(
                            _currentFlashMode == FlashMode.torch?Icons.flash_on:Icons.flash_off,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
          ),//
        ],
      ),
    );
  }
}

//Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ElevatedButton(
//             onPressed: () async {
//               pictureFile = await controller.takePicture();
//               setState(() {});
//             },
//             child: const Text('Capture Image'),
//           ),
//         ),