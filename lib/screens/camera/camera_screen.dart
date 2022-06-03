import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_boilerplate/main.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;

  int _pointers = 0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _currentScale = 1.0;
  double _baseScale = 1.0;
  @override
  void initState() {
    super.initState();
    onNewCameraSelected(cameras[1]);
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
      debugPrint('Error initializing camera: $e');
    }
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (_controller == null || _pointers != 2) {
      return;
    }

    _currentScale = (_baseScale * details.scale)
        .clamp(_minAvailableZoom, _maxAvailableZoom);

    await _controller!.setZoomLevel(_currentScale);
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (_controller == null) {
      return;
    }

    final CameraController cameraController = _controller!;

    final Offset offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
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
              child: Stack(
                children: [
                  Listener(
                    onPointerDown: (_) => _pointers++,
                    onPointerUp: (_) => _pointers--,
                    child: CameraPreview(
                      _controller!,
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onScaleStart: _handleScaleStart,
                            onScaleUpdate: _handleScaleUpdate,
                            onTapDown: (TapDownDetails details) =>
                                onViewFinderTap(details, constraints),
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: cameras
                        .map(
                          (e) => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              elevation: 8,
                            ),
                            onPressed: () {
                              onNewCameraSelected(e);
                            },
                            child: Text(e.name),
                          ),
                        )
                        .toList(),
                  ),
                  // ListView.separated(
                  //   padding: const EdgeInsets.all(7),
                  //   scrollDirection: Axis.horizontal,
                  //   itemCount: cameras.length,
                  //   itemBuilder: (context, index) {
                  //     return Text(cameras[index].name);
                  //   },
                  //   separatorBuilder: (BuildContext context, int index) {
                  //     return const SizedBox(width: 5);
                  //   },
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 8,
                    shape: const CircleBorder(),
                    minimumSize: const Size.square(80),
                  ),
                  onPressed: () async {},
                  child: const Icon(Icons.camera),
                ),
              ),
            ),
          ],
        ));
  }
}
