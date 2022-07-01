import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluuter_boilerplate/utils/app_texts/app_texts.dart';
import 'package:fluuter_boilerplate/utils/extensions/functions.dart';
import 'package:fluuter_boilerplate/utils/extensions/string_extensions.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerScreeen extends StatefulWidget {
  const QrScannerScreeen({Key? key}) : super(key: key);

  @override
  State<QrScannerScreeen> createState() => _QrScannerScreeenState();
}

class _QrScannerScreeenState extends State<QrScannerScreeen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;

  @override
  void initState() {
    super.initState();
    cameraPermissionHandler();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.qr.translateTo(context)),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderWidth: 1.0,
                    overlayColor: const Color.fromARGB(174, 172, 91, 197),
                    // cutOutHeight: 4,
                  ),
                  onPermissionSet: (ctrl, p) =>
                      _onPermissionSet(context, ctrl, p),
                ),
                const Positioned(
                  bottom: 200,
                  left: 100,
                  child: Icon(Icons.onetwothree),
                ),
                const Positioned(
                  bottom: 200,
                  left: 180,
                  child: Icon(Icons.onetwothree),
                ),
                Positioned(
                  bottom: 200,
                  left: 260,
                  child: InkWell(
                    onTap: () async {
                      await controller?.toggleFlash();
                    },
                    child: const SizedBox(
                      height: 20,
                      width: 20,
                      child: Icon(Icons.flash_on),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;

    controller.scannedDataStream.listen(
      (scanData) async {
        controller.pauseCamera();

        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => QrcodeData(scannedQrData: scanData),
          ),
        )
            .then((value) async {
          await controller.resumeCamera();
        });
      },
      onError: (e) async {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(e),
            );
          },
        );
      },
      onDone: () async {
        controller.dispose();
      },
      cancelOnError: true,
    );
    controller.pauseCamera();
    controller.resumeCamera();
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class QrcodeData extends StatelessWidget {
  const QrcodeData({
    Key? key,
    required this.scannedQrData,
  }) : super(key: key);
  final Barcode scannedQrData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanned Data'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text(scannedQrData.code ?? '')),
        ],
      ),
    );
  }
}
