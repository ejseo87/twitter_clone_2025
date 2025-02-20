import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:twitter_clone_2025/contants/sizes.dart';
import 'widgets/display_alert_message.dart';

class CameraScreen extends StatefulWidget {
  static const String routeUrl = "camera";
  static const String routeName = "camera";
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hadPermission = false;
  bool _isPermissionDenied = false;
  bool _isSelfieMode = false;
  bool _prepareCameraDispose = false;
  bool _cameraInitialized = false;
  FlashMode _flashMode = FlashMode.off;

  //in case of iosSimulator, we do not have any camera.
  late final bool _noCamera = kDebugMode && Platform.isIOS;

  late final CameraController _cameraController;

  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  late final Animation<double> _buttonAnimation = Tween(
    begin: 1.0,
    end: 1.5,
  ).animate(_buttonAnimationController);

  Future<void> initCamera() async {
    print("_isSelfieMode = $_isSelfieMode");
    print("_flashMode = $_flashMode");

    final cameras = await availableCameras();

    if (cameras.isEmpty) return;

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        _cameraInitialized = true;
      });
    }).catchError((e) {
      print(e);
    });

    await _cameraController.setFlashMode(_flashMode);
  }

  Future<void> initPermissions() async {
    final cameraPermision = await Permission.camera.request();

    print("cameraPermision.isDenied = ${cameraPermision.isDenied}");
    print(
        "cameraPermision.isPermanentlyDenied = ${cameraPermision.isPermanentlyDenied}");

    final cameraDenied =
        cameraPermision.isDenied || cameraPermision.isPermanentlyDenied;

    if (!cameraDenied) {
      _hadPermission = true;
      await initCamera();
    } else {
      _isPermissionDenied = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (!_noCamera) {
      initPermissions(); // 내가 만든 함수
    } else {
      setState(() {
        _hadPermission = true;
      });
    }

    //유저가 applicaton에서 벗어나는지 돌아오는지 알수 있게 한다
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    if (!_noCamera && _cameraInitialized) {
      _cameraController.dispose();
    }

    _buttonAnimationController.dispose();
    super.dispose();
  }

  Future<void> _toggleFlashMode() async {
    if (_flashMode == FlashMode.always) {
      _flashMode = FlashMode.off;
    } else if (_flashMode == FlashMode.off) {
      _flashMode = FlashMode.always;
    }
    await _cameraController.setFlashMode(_flashMode);
    setState(() {});
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;

    await initCamera();
    setState(() {});
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (_noCamera) return;
    if (!_hadPermission) return;
    if (!_cameraInitialized || !_cameraController.value.isInitialized) return;

    if (state == AppLifecycleState.inactive) {
      setState(() {
        _prepareCameraDispose = true;
      });
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      await initCamera();
      _prepareCameraDispose = false;
      setState(() {});
    }
  }

  Future<void> _takePicture() async {
    if (!_noCamera ||
        !_cameraInitialized ||
        !_cameraController.value.isInitialized) {
      return;
    }
    _buttonAnimationController.forward();
    final image = await _cameraController.takePicture();

    print("Take a picture : $image");
    _buttonAnimationController.reverse();

    if (!mounted) return;
    Navigator.of(context).pop(image);
  }

  Future<void> _onPickImagePressed() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    //whetn user did not pick anything, do nothing.
    if (image == null) return;

    if (!mounted) return;

    Navigator.of(context).pop(image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            color: Color(0xFF1B1A16),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(Sizes.size20),
              bottomRight: Radius.circular(Sizes.size20),
            )),
        child: _isPermissionDenied
            ? const DisplayAlertMessage(
                alertMessage: "Please check camera  permissions!",
              )
            : !_hadPermission //|| !_cameraInitialized
                ? const DisplayAlertMessage(alertMessage: "Initializing...")
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      if (!_noCamera && _cameraInitialized)
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(
                                Sizes.size20,
                              ),
                            ),
                            child: CameraPreview(_cameraController),
                          ),
                        ),
                      const Positioned(
                        top: Sizes.size52,
                        left: Sizes.size20,
                        child: CloseButton(
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        bottom: Sizes.size96,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (!_noCamera)
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: IconButton(
                                    onPressed: _toggleFlashMode,
                                    icon: _flashMode == FlashMode.always
                                        ? const Icon(
                                            Icons.flash_on_rounded,
                                            size: Sizes.size32,
                                            color: Colors.white,
                                          )
                                        : const Icon(
                                            Icons.flash_off_rounded,
                                            size: Sizes.size32,
                                            color: Colors.white,
                                          ),
                                  ),
                                ),
                              ),
                            GestureDetector(
                              onTap: _takePicture,
                              child: ScaleTransition(
                                scale: _buttonAnimation,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: Sizes.size80 + Sizes.size16,
                                  height: Sizes.size80 + Sizes.size16,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: Sizes.size3,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: Container(
                                    width: Sizes.size80,
                                    height: Sizes.size80,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (!_noCamera)
                              Expanded(
                                  child: Container(
                                alignment: Alignment.center,
                                child: IconButton(
                                  onPressed: _toggleSelfieMode,
                                  icon: const Icon(
                                    Icons.cameraswitch,
                                    size: Sizes.size32,
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                          ],
                        ),
                      ),
                    ],
                  ),
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 100,
          child: BottomAppBar(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size10,
              horizontal: Sizes.size16,
            ),
            child: Row(
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Camera",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: _onPickImagePressed,
                      child: const Opacity(
                        opacity: 0.7,
                        child: Text(
                          "Library",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
