import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class QrGeneratorAndShare extends ConsumerStatefulWidget {
  const QrGeneratorAndShare({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QrGeneratorAndShareState();
}

class _QrGeneratorAndShareState extends ConsumerState<QrGeneratorAndShare> {
  String qrToGenerate = "Hello World";
  final GlobalKey qrcontainerKey = GlobalKey();
  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Qr Generator"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    qrToGenerate = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Qr Generator',
                  border: const OutlineInputBorder(),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 80.0),
                    child: RepaintBoundary(
                      key: qrcontainerKey,
                      child: Container(
                        color: Colors.white,
                        child: QrImage(
                          data: qrToGenerate,
                          version: QrVersions.auto,
                          size: 200,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 40.0),
                    child: InkWell(
                      onTap: () async {
                        try {
                          RenderRepaintBoundary boundary = qrcontainerKey.currentContext!
                              .findRenderObject() as RenderRepaintBoundary;

                          var image = await boundary.toImage();
                          ByteData? byteData = await image.toByteData(
                              format: ImageByteFormat.png);
                          Uint8List pngBytes = byteData!.buffer.asUint8List();
                          final appDir =
                              await getApplicationDocumentsDirectory();
                          DateTime datetime = DateTime.now();
                          file = await File('${appDir.path}/$datetime.png')
                              .create();
                          await file?.writeAsBytes(pngBytes);
                          await Share.shareXFiles(
                            [XFile(file!.path, mimeType: "image/png")],
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Failed to share QR",
                              ),
                            ),
                          );
                        }
                      },
                      child: Icon(Icons.share),
                    ),
                  ),
                ],
              ),
              // const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
