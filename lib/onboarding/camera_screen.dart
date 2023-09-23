import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import '../util/snackbar.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> cameras;
  File file = File("");
  var boolVN = ValueNotifier(false);
  var currentView = ViewType.cameraView;
  var imagePath = "";

  @override
  void initState() {
    getCamera();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder(
          valueListenable: boolVN,
          builder: (_, bool value, __) {
            if (value == false) {
              return const Center(child: CircularProgressIndicator());
            }
            if (cameras.isEmpty) {
              Snackbar.showToast("No camera available", context);
            } else if (cameras.length < 2) {} else if (cameras.length > 1) {
              var cameraSet = false;
              for (CameraDescription c in cameras) {
                if (c.lensDirection == CameraLensDirection.front) {
                  sGetCamera(c);
                  cameraSet = true;
                  break;
                }
              }
              if (cameraSet == false) {
                sGetCamera(cameras.first);
              }
            }
            return FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (currentView == ViewType.cameraView) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_controller);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                } else {
                  return Image.file(
                    File(imagePath),
                    errorBuilder: (_, __, ___) {
                      print("object ************** error occurred");
                      return const SizedBox();
                    },
                  );
                }
              },
            );
          },
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 200,
        child: InkWell(
          onTap: () async {
            try {
              await _initializeControllerFuture;
              final image = await _controller.takePicture();
              imagePath = image.path;
              setState(() {
                currentView = ViewType.pictureView;
              });
            } catch (e) {
              if (kDebugMode) {
                print(e);
              }
            }
          },
          child: const CircleAvatar(
            radius: 30,
            child: Icon(
              Icons.camera_alt,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }

  void getCamera() async {
    cameras = await availableCameras();
    boolVN.value = true;
  }

  void sGetCamera(CameraDescription camera) {
    _controller = CameraController(camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }
}

class ViewType {
  static int pictureView = 0;
  static int cameraView = 1;
}