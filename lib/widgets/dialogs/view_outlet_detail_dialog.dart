import 'package:flutter/material.dart';

import '../../app/utlis/utils.dart';
import '../../common/common.dart';

class _Constant {
  static const titleDialog = "Xem chi tiết thông tin cửa hàng?";
  static const descriptionDialog = "Cửa hàng này đã được viếng thăm. Bạn muốn xem kết quả hay thực hiện viếng thăm lại?";
  static const viewOutletDetail = "Xem chi tiết khách hàng";
  static const reCheckIn = "Viếng thăm lại";
}

class ViewOutletDetailDialog extends StatefulWidget {
  const ViewOutletDetailDialog({Key? key}) : super(key: key);

  @override
  State<ViewOutletDetailDialog> createState() => _ViewOutletDetailDialogState();
}

class _ViewOutletDetailDialogState extends State<ViewOutletDetailDialog> {
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
                Text(_Constant.titleDialog,
                  style: themeOwn.textStyleHeaderTitle,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: NumberConstant.basePaddingLarge),
                  child: Text(_Constant.descriptionDialog,
                    style: themeOwn.textStyleListDetail,
                  ),
                ),
                const SizedBox(height: NumberConstant.basePaddingLarge,),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Get.back(result: 1);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(NumberConstant.basePaddingLarge),
                    decoration: BoxDecoration(
                      color: themeOwn.mainColor,
                      border: Border.all(
                        color: themeOwn.mainColor,
                      ),
                      borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
                    ),
                    child: Center(
                      child: Text(_Constant.viewOutletDetail,
                        style: themeOwn.textStyleListTitle!.copyWith(
                          color: themeOwn.backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: NumberConstant.basePaddingLarge,),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Get.back(result: 2);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(NumberConstant.basePaddingLarge),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: themeOwn.mainColor,
                      ),
                      borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
                    ),
                    child: Center(
                      child: Text(_Constant.reCheckIn,
                        style: themeOwn.textStyleListTitle!.copyWith(
                          color: themeOwn.mainColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: NumberConstant.basePaddingLarge,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
