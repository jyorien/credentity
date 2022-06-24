import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:credentity/main.dart';
import 'passport_details_screen.dart';

class OcrScanScreen extends StatefulWidget {
  const OcrScanScreen({Key? key}) : super(key: key);

  @override
  State<OcrScanScreen> createState() => _OcrScanScreenState();
}

class _OcrScanScreenState extends State<OcrScanScreen> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
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
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: CameraPreview(controller),
          ),
          Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      Row(
                        children: [
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
                      controller
                          .takePicture()
                          .then((value) => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => PassportDetailsScreen(
                                      filePath: value.path))))
                          .onError((error, stackTrace) => print(error));
                    },
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
    ;
  }
}
