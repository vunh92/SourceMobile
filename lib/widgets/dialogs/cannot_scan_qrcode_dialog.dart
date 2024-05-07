import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/utlis/utils.dart';
import '../../common/common.dart';

class _Constant {
  static const titleDialog = AppString.cannotScanQrcode;
  static const descriptionDialog = "Chọn lí do bạn không thể quét mã QR từ danh sách dưới đây.";
  static const coolerMissing = "Cooler thất lạc";
  static const qrcodeDamage = "Mã QR bị hỏng";
}

class CannotScanQrcodeDialog extends StatefulWidget {

  const CannotScanQrcodeDialog({Key? key}) : super(key: key);

  @override
  State<CannotScanQrcodeDialog> createState() => _CannotScanQrcodeDialogState();
}

class _CannotScanQrcodeDialogState extends State<CannotScanQrcodeDialog> {
  late OwnThemeFields themeOwn;
  int resultChecked = 0;

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
                Text(_Constant.titleDialog,
                  style: themeOwn.textStyleHeaderTitle,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: NumberConstant.basePaddingLarge),
                  child: Text(_Constant.descriptionDialog,
                    style: themeOwn.textStyleListDetail,
                  ),
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      resultChecked = 1;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(NumberConstant.basePaddingLarge),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: themeOwn.dividerColor,
                      ),
                      borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          assetIconsPath + iconEyeSlashSvg,
                          width: NumberConstant.baseSizeIconSmall,
                          color: AppColor.appColorDark3,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(width: NumberConstant.basePaddingMedium,),
                        Text(_Constant.coolerMissing,
                          style: themeOwn.textStyleListTitle!.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: NumberConstant.baseSizeIconSmall,
                          width: NumberConstant.baseSizeIconSmall,
                          child: Checkbox(
                            side: BorderSide(width: 1, color: themeOwn.dividerColor),
                            activeColor: themeOwn.mainColor,
                            value: resultChecked == 1,
                            shape: const CircleBorder(),
                            onChanged: (bool? value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: NumberConstant.basePaddingLarge,),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      resultChecked = 2;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(NumberConstant.basePaddingLarge),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: themeOwn.dividerColor,
                      ),
                      borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          assetIconsPath + iconQrcodeDamageSvg,
                          width: NumberConstant.baseSizeIconSmall,
                          color: AppColor.appColorDark3,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(width: NumberConstant.basePaddingMedium,),
                        Text(_Constant.qrcodeDamage,
                          style: themeOwn.textStyleListTitle!.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: NumberConstant.baseSizeIconSmall,
                          width: NumberConstant.baseSizeIconSmall,
                          child: Checkbox(
                            side: BorderSide(width: 1, color: themeOwn.dividerColor),
                            activeColor: themeOwn.mainColor,
                            value: resultChecked == 2,
                            shape: const CircleBorder(),
                            onChanged: (bool? value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: NumberConstant.basePaddingLarge,),
              ],
            ),
          ),
          _bottomButton(resultChecked),
        ],
      ),
    );
  }

  Widget _bottomButton(int resultChecked) {
    return RawMaterialButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(NumberConstant.baseRadiusBorderMedium),
        ),
      ),
      fillColor: resultChecked == 0
          ? AppColor.mainColor.withOpacity(0.5)
          : AppColor.mainColor,
      onPressed: () {
        resultChecked == 0 ? null : Get.back(result: resultChecked);
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(NumberConstant.basePaddingLarge),
          child: Text(AppString.doneUppercase,
            style: themeOwn.textStyleMainButton!.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}