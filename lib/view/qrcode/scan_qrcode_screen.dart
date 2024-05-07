import 'package:cooler_mdlz/view/qrcode/qrcode_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/utlis/utils.dart';
import '../../common/common.dart';
import '../../controller/scan_qrcode_controller.dart';

class _Constant {
  static const sizeIconScan = 50.0;
  static const sizeBorderScan = 172.0;
}

class ScanQrcodeScreen extends StatelessWidget {
  const ScanQrcodeScreen({
    Key? key,
    required this.themeOwn,
    required this.controller,
  }) : super(key: key);

  final OwnThemeFields themeOwn;
  final ScanQrcodeController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            height: _Constant.sizeBorderScan,
            width: _Constant.sizeBorderScan,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_Constant.sizeBorderScan),
              border: Border.all(
                width: 2,
                color: themeOwn.mainColor,
              ),
            ),
            child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () async {
                final result = await Get.toNamed(QrcodeViewScreen.route);
                if(result == null) return;
                controller.checkScan(qrcode: result);
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      assetIconsPath + iconQrcodeSvg,
                      width: _Constant.sizeIconScan,
                      color: themeOwn.mainColor,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(height: NumberConstant.basePaddingLarge,),
                    Text(AppString.scanQrcode,
                      style: themeOwn.textStyleMainButton,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: NumberConstant.heightDevice(context) / 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () async {
                  final result = await Get.dialog(const CannotScanQrcodeDialog());
                  if(result == null) return;
                  controller.cannotScan(reason: result);
                },
                child: Text(AppString.cannotScanQrcode,
                  style: themeOwn.textStyleMainButton!.copyWith(color: themeOwn.errorColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
