import 'package:flutter/material.dart';

import '../../app/utlis/utils.dart';
import '../../common/common.dart';

class _Constant {
  static const titleDialog = "Sai vị trí cửa hàng";
  static const wrongLocationDescription = "Kiểm tra lại vị trí của bạn và cửa hàng. Có vẻ bạn đang ở xa cửa hàng này.";
}

class WrongLocationDialog extends StatefulWidget {
  const WrongLocationDialog({Key? key}) : super(key: key);

  @override
  State<WrongLocationDialog> createState() => _WrongLocationDialogState();
}

class _WrongLocationDialogState extends State<WrongLocationDialog> {
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
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: NumberConstant.basePaddingLarge),
                  child: Image.asset(
                    assetImagePath + wrongLocation,
                    width: 60,
                    height: 60,
                    fit: BoxFit.fill,
                  ),
                ),
                Text(_Constant.titleDialog,
                  style: themeOwn.textStyleHeaderTitle!.copyWith(color: AppColor.errorColor),
                ),
                Text(_Constant.wrongLocationDescription,
                  style: themeOwn.textStyleListDetail,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: NumberConstant.marginInfo,),
              ],
            ),
          ),
          RawMaterialButton(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(NumberConstant.baseRadiusBorderMedium),
              ),
            ),
            fillColor: AppColor.mainColor,
            onPressed: () {
              Get.back();
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(NumberConstant.basePaddingLarge),
                child: Text(AppString.doneUppercase,
                  style: themeOwn.textStyleMainButton!.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}