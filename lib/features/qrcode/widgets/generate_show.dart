import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credentity/features/qrcode/qrcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';

class GenerateShow extends StatefulWidget {
  const GenerateShow({
    Key? key,
    required this.record,
    required this.setRecord,
  }) : super(key: key);

  final Record record;

  final Function(Record) setRecord;

  @override
  State<GenerateShow> createState() => _GenerateShowState();
}

class _GenerateShowState extends State<GenerateShow> {
  final _genKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    Timer.periodic(
      const Duration(seconds: 1),
      (_) => checkForRefresh(),
    );
  }

  void checkForRefresh() async {
    if (widget.record.expires.toDate().difference(DateTime.now()).inSeconds < 1) {
      final record = Record(
        uuid: const Uuid().v4(),
        expires: Timestamp.fromDate(
          DateTime.now().add(const Duration(minutes: 5)),
        ),
        data: widget.record.data,
      );

      await FirebaseFirestore.instance.collection("records").doc(widget.record.uuid).delete();
      await FirebaseFirestore.instance.collection("records").doc(record.uuid).set(record.toJson());

      widget.setRecord(record);
    } else {
      setState(() {});
    }
  }

  void handleDownloadClick() async {
    RenderRepaintBoundary boundary =
        _genKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    // TODO: Replace path on iOS
    File imgFile = File('/storage/emulated/0/Download/${widget.record.uuid}.png');
    await imgFile.writeAsBytes(pngBytes);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.check, color: Colors.white),
            SizedBox(width: 16),
            Text("Image saved to Downloads folder"),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        Stack(
          children: [
            RepaintBoundary(
              key: _genKey,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: QrImage(
                  foregroundColor: Colors.black,
                  data: widget.record.uuid,
                  size: 250,
                ),
              ),
            ),
            Container(
              width: 270,
              height: 270,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: QrImage(
                  foregroundColor: Colors.white,
                  data: widget.record.uuid,
                  size: 168,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: 180,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Builder(
              builder: (context) {
                final difference = widget.record.expires.toDate().difference(DateTime.now());
                final minutes = difference.inMinutes > 0 ? difference.inMinutes : 0;
                final seconds = difference.inSeconds > 0 ? difference.inSeconds : 0;

                return Text(
                  "${minutes.toString().padLeft(2, "0")}:${(seconds % 60).toString().padLeft(2, "0")}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: "What is this QR code used for?\n",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                      "This QR code can be used to retrieve information from user(s). If a Credentity user scans this and authorizes their information to be shared, you can see it here!\n\n",
                ),
                TextSpan(
                  text: "What is this timer for?\n",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                      "To ensure for improved security, the QR code will expire within 5 minutes and will re-generate itself",
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: 160,
          height: 44,
          child: ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.resolveWith(
                (states) => const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
              ),
              backgroundColor: MaterialStateColor.resolveWith(
                (states) => const Color(0xFFD9D9D9),
              ),
              shape: MaterialStateProperty.resolveWith(
                (states) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            onPressed: handleDownloadClick,
            child: Row(
              children: const [
                Icon(
                  Icons.file_download_outlined,
                  color: Colors.black,
                ),
                SizedBox(width: 4),
                Text(
                  "Download",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
