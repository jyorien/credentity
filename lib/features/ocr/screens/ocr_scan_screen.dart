import 'package:camera/camera.dart';
import 'package:credentity/features/ocr/ocr.dart';
import 'package:credentity/main.dart';
import 'package:flutter/material.dart';

class OcrScanScreen extends StatefulWidget {
  const OcrScanScreen({Key? key}) : super(key: key);

  @override
  State<OcrScanScreen> createState() => _OcrScanScreenState();
}

class _OcrScanScreenState extends State<OcrScanScreen> {
  late final _controller = CameraController(cameras[0], ResolutionPreset.max);

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
    if (!_controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: CameraPreview(_controller),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.flash_off,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.help_outline_outlined,
                          color: Colors.white,
                        )
                      ],
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    _controller
                        .takePicture()
                        .then((value) => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PassportDetailsScreen(filePath: value.path),
                              ),
                            ))
                        .onError((error, stackTrace) => print(error));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
