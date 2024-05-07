import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../app/utlis/utils.dart';
import '../../common/common.dart';

class _Constant {
  static const back = 'Back';
  static const noPermission = 'no Permission';
}

class QrcodeViewScreen extends StatefulWidget {
  static const route = '/qrcode_view_screen';

  const QrcodeViewScreen({Key? key}) : super(key: key);

  @override
  State<QrcodeViewScreen> createState() => _QrcodeViewScreenState();
}

class _QrcodeViewScreenState extends State<QrcodeViewScreen> {
  late OwnThemeFields themeOwn;
  Barcode? result;
  QRViewController? qrController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrController!.pauseCamera();
    } else if (Platform.isIOS) {
      qrController!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    themeOwn = Theme.of(context).own();
    return Scaffold(
      appBar: AppBar(
        title: const Text(_Constant.back,),
        elevation: 0,
      ),
      body: Container(
        color: themeOwn.mainColor,
        padding: const EdgeInsets.all(NumberConstant.basePaddingLarge),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderMedium),
          child: Column(
            children: [
              Expanded(
                child: _buildQrView(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = NumberConstant.widthDevice(context)/2;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.white,
        borderRadius: 0,
        borderLength: NumberConstant.basePaddingSmall,
        borderWidth: NumberConstant.basePaddingSmall,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      qrController = controller;
      qrController!.resumeCamera();
    });
    qrController!.scannedDataStream.listen((scanData) {
      if(!result.isNull) return;
      result = scanData;
      Get.back(result: scanData.code ?? '');
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(_Constant.noPermission)),
      );
    }
  }

  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }
}
