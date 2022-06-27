import 'dart:io';

import 'package:camera/camera.dart';
import 'package:credentity/features/ocr/ocr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../../../main.dart';
import '../providers/user_provider.dart';

class SelfieScreen extends StatefulWidget {
  const SelfieScreen({Key? key}) : super(key: key);

  @override
  State<SelfieScreen> createState() => _SelfieScreenState();
}

class _SelfieScreenState extends State<SelfieScreen> {
  late final _controller = CameraController(cameras[1], ResolutionPreset.max);
  File? _photoFile;

  @override
  void initState() {
    super.initState();

    _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print("User denied camera access");
            break;
          default:
            print(e.code);
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const Text("TAKE A SELFIE"),
                  Row(
                    children: const [
                      Icon(Icons.flash_off),
                      SizedBox(
                        width: 10.0,
                      ),
                      Icon(Icons.help_outline_outlined)
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 350,
                child: SizedBox.expand(
                    child: ClipRect(
                  child: OverflowBox(
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: SizedBox(
                          height: 350,
                          width: 350 / _controller.value.aspectRatio,
                          child: _photoFile != null
                              ? Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.rotationY(math.pi),
                                  child: Image.file(_photoFile!))
                              : CameraPreview(_controller),
                        ),
                      )),
                )),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.center,
                child: _photoFile != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  _photoFile = null;
                                });
                              },
                              child: const Text("RETAKE SELFIE")),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: const BorderSide(
                                              color:
                                                  Colors.deepPurpleAccent)))),
                              onPressed: () {
                                final _userProvider =
                                    context.read<UserProvider>();
                                _userProvider.setFace(_photoFile!);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const VerifyStepsScreen(),
                                  ),
                                );
                              },
                              child: const Text("USE THIS SELFIE"))
                        ],
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.takePicture().then((value) {
                            setState(() {
                              _photoFile = File.fromUri(Uri.file(value.path));
                            });
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.deepPurpleAccent,
                              borderRadius: BorderRadius.circular(24)),
                        ),
                      ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
