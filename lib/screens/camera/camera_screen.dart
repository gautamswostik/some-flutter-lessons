import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_boilerplate/main.dart';
import 'package:fluuter_boilerplate/screens/camera/image_preview.dart';
import 'package:fluuter_boilerplate/utils/extensions/functions.dart';
import 'package:fluuter_boilerplate/widgets/custom_button.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;

  @override
  void initState() {
    super.initState();
    cameraPermissionHandler();
    onNewCameraSelected(cameras[1]);
  }

  void _showCameraException(CameraException e) {
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(cameraController.description);
    }
    super.didChangeAppLifecycleState(state);
  }

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final CameraController? previousCameraController = _controller;

    if (previousCameraController != null) {
      _controller = null;
      await previousCameraController.dispose();
    }

    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    _controller = cameraController;

    if (cameraController.value.hasError) {
      showInSnackBar('Camera error ${cameraController.value.errorDescription}');
    }

    cameraController.addListener(() {
      if (mounted) setState(() {});
      if (cameraController.value.hasError) {
        showInSnackBar(
            'Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }
  }

  Future<XFile> takePicture() async {
    try {
      final XFile file = await _controller!.takePicture();
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  void saveImage(XFile image) async {
    createFolder().then((value) async {
      File imageFile = File(image.path);
      String fileFormat = imageFile.path.split('.').last;
      await imageFile
          .copy('$value/${DateTime.now().millisecondsSinceEpoch}.$fileFormat');
    });
  }

  Future<String> createFolder() async {
    final path = Directory("storage/emulated/0/DCIM/boilerplate_images");

    if ((await path.exists())) {
      return path.path;
    } else {
      path.create();
      return path.path;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color: Colors.purple,
                  width: 3.0,
                ),
              ),
              child: CameraPreview(
                _controller!,
              ),
            ),
          ),
          //* List of cameras in the system
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: cameras
          //       .map(
          //         (e) => ElevatedButton(
          //           style: ElevatedButton.styleFrom(
          //             // primary: Colors.transparent,
          //             elevation: 8,
          //           ),
          //           onPressed: () {
          //             onNewCameraSelected(e);
          //           },
          //           child: Text(e.name),
          //         ),
          //       )
          //       .toList(),
          // ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomCircularButtonWithIcon(
                onPressed: () async {
                  if (_controller!.description.name == '1') {
                    onNewCameraSelected(
                      const CameraDescription(
                          name: "2",
                          sensorOrientation: 90,
                          lensDirection: CameraLensDirection.back),
                    );
                  } else {
                    onNewCameraSelected(
                      const CameraDescription(
                          name: "1",
                          sensorOrientation: 270,
                          lensDirection: CameraLensDirection.front),
                    );
                  }
                },
                buttonIcon: Icons.flip_camera_android,
              ),
              CustomCircularButtonWithIcon(
                onPressed: () async {
                  await takePicture().then(
                    (value) async {
                      saveImage(value);
                      // if (!mounted) return;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (cotext) => ImagePreviewWIdget(
                            image: value,
                          ),
                        ),
                      );
                    },
                  );
                },
                buttonIcon: Icons.camera,
              ),
              const SizedBox(),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
