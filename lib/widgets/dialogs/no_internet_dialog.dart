import 'package:cooler_mdlz/controller/home_controller.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/utlis/utils.dart';
import '../../common/common.dart';
import '../../model/entities.dart';

class _Constant {
  static const titleDialog = "Oops!\nCó lỗi xảy ra";
  static const descriptionDialog = "Ứng dụng đang kết nối đến hệ thống nhưng có lỗi xảy ra. Hãy kiểm tra:";
  static const noInternetConnection = "Kết nối Internet";
  static const invalidDeviceUsed = "Không đúng thiết bị";

}

class NoInternetDialog extends StatefulWidget {
  const NoInternetDialog({Key? key, required this.error, }) : super(key: key);
  final ErrorConnectedEnum error;

  @override
  State<NoInternetDialog> createState() => _NoInternetDialogState();
}

class _NoInternetDialogState extends State<NoInternetDialog> {
  late OwnThemeFields themeOwn;

  @override
  Widget build(BuildContext context) {
    themeOwn = Theme.of(context).own();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderMedium),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(NumberConstant.basePaddingLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: NumberConstant.basePaddingMedium),
                  child: SvgPicture.asset(
                    assetImagePath + settingSvg,
                    fit: BoxFit.fill,
                  ),
                ),
                Text(_Constant.titleDialog,
                  style: themeOwn.textStyleHeaderTitle,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: NumberConstant.basePaddingLarge),
                  child: Text(_Constant.descriptionDialog,
                    style: themeOwn.textStyleListDetail,
                  ),
                ),
                if(widget.error == ErrorConnectedEnum.WIFI)
                  _itemWidget(
                    icon: assetIconsPath + iconWifiErrorSvg,
                    name: _Constant.noInternetConnection,
                  ),
                if(widget.error == ErrorConnectedEnum.DEVICE)
                  _itemWidget(
                    icon: assetIconsPath + iconMobileSvg,
                    name: _Constant.invalidDeviceUsed,
                  ),_itemIEMIWidget()
              ],
            ),
          ),
          _bottomButton(),
        ],
      ),
    );
  }

  Widget _itemWidget({required String icon, required String name}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              icon,
              width: NumberConstant.baseSizeIconSmall,
              color: AppColor.appColorDark3,
              fit: BoxFit.fill,
            ),
            const SizedBox(width: NumberConstant.basePaddingMedium,),
            Text(name,
              style: themeOwn.textStyleListDetail,
            ),
          ],
        ),
        const SizedBox(height: NumberConstant.basePaddingLarge,),
      ],
    );
  }



  Widget _itemIEMIWidget() {
    var homeController= Get.find<HomeController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: NumberConstant.basePaddingMedium,),
            Text("Thông tin thiết bị: "+(homeController.deviceModel.value.imei??""),
              style: themeOwn.textStyleListDetail,
            ),
          ],
        ),
        const SizedBox(height: NumberConstant.basePaddingLarge,),
      ],
    );
  }


  Widget _bottomButton() {
    return RawMaterialButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(NumberConstant.baseRadiusBorderMedium),
        ),
      ),
      fillColor: AppColor.mainColor,
      onPressed: () {
        Get.back(result: true);
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(NumberConstant.basePaddingLarge),
          child: Text(AppString.okUppercase,
            style: themeOwn.textStyleMainButton!.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}




