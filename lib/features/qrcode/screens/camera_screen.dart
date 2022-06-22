import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const CameraScreen(),
    );
  }

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  static const DARREN_MOVE_UP = 30;
  final _qrKey = GlobalKey();
  late QRViewController _controller;
  bool _scanning = true;
  bool _flash = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onDataScanned(Barcode barcode) {
    if (!_scanning) return;
    _scanning = false;
    _controller.pauseCamera();

    print(barcode.code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          splashRadius: 20,
          color: Colors.black,
          icon: const Icon(Icons.arrow_back),
          onPressed: Navigator.of(context).pop,
        ),
        title: const Text("Scan a QR Code"),
        actions: [
          IconButton(
            splashRadius: 20,
            color: Colors.black,
            icon: Icon(_flash ? Icons.flash_on : Icons.flash_off),
            onPressed: () {
              _controller.toggleFlash();
              setState(() => _flash = !_flash);
            },
          ),
          IconButton(
            splashRadius: 20,
            color: Colors.black,
            icon: const Icon(Icons.help_outline),
            onPressed: () {},
          )
        ],
      ),
      body: Stack(
        children: [
          QRView(
            key: _qrKey,
            onQRViewCreated: (controller) {
              _controller = controller;
              _controller.scannedDataStream.listen(onDataScanned);
            },
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
            width: (MediaQuery.of(context).size.width - 280) / 2,
            height: MediaQuery.of(context).size.height,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              width: (MediaQuery.of(context).size.width - 280) / 2,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              width: 280,
              height: (MediaQuery.of(context).size.height - 386) / 2 - DARREN_MOVE_UP,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              width: 280,
              height: (MediaQuery.of(context).size.height - 386) / 2 + DARREN_MOVE_UP,
            ),
          ),
          Positioned(
            top: ((MediaQuery.of(context).size.height - 386) / 2) - 3 - DARREN_MOVE_UP,
            right: ((MediaQuery.of(context).size.width - 280) / 2) - 7,
            child: SvgPicture.asset("assets/icons/qr-corner.svg"),
          ),
          Positioned(
            bottom: ((MediaQuery.of(context).size.height - 386) / 2) - 7 + DARREN_MOVE_UP,
            right: ((MediaQuery.of(context).size.width - 280) / 2) - 2,
            child: Transform.rotate(
              angle: 90 * pi / 180,
              child: SvgPicture.asset("assets/icons/qr-corner.svg"),
            ),
          ),
          Positioned(
            bottom: ((MediaQuery.of(context).size.height - 386) / 2) - 3 + DARREN_MOVE_UP,
            left: ((MediaQuery.of(context).size.width - 280) / 2) - 7,
            child: Transform.rotate(
              angle: 180 * pi / 180,
              child: SvgPicture.asset("assets/icons/qr-corner.svg"),
            ),
          ),
          Positioned(
            top: ((MediaQuery.of(context).size.height - 386) / 2) - 7 - DARREN_MOVE_UP,
            left: ((MediaQuery.of(context).size.width - 280) / 2) - 2,
            child: Transform.rotate(
              angle: 270 * pi / 180,
              child: SvgPicture.asset("assets/icons/qr-corner.svg"),
            ),
          ),
          Positioned(
            bottom: ((MediaQuery.of(context).size.height - 386) / 2) - 100 + DARREN_MOVE_UP,
            left: (MediaQuery.of(context).size.width - 300) / 2,
            child: Material(
              color: const Color(0x001E2022).withOpacity(1),
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
              child: const SizedBox(
                width: 300,
                height: 50,
                child: Center(
                  child: Text(
                    "Point your camera at the QR Code",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
