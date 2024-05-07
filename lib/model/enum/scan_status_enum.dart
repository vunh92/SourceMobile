import 'package:cooler_mdlz/common/common.dart';
import 'package:flutter/material.dart';

import '../../app/utlis/utils.dart';

enum ScanStatusEnum {
  NONE,
  SUCCESS,
  FAIL,
  MISSING,
  DAMAGE,
}

extension HelperScanStatusEnum on ScanStatusEnum {
  String name() {
    switch (this) {
      case ScanStatusEnum.NONE:
        return "Cooler Not Setup";
      case ScanStatusEnum.SUCCESS:
        return AppString.successCooler;
      case ScanStatusEnum.FAIL:
        return AppString.wrongCooler;
      case ScanStatusEnum.MISSING:
        return AppString.missingCooler;
      case ScanStatusEnum.DAMAGE:
        return AppString.qrDamage;
      default:
        return "Cooler Not Setup";
    }
  }

  Color color() {
    switch (this) {
      case ScanStatusEnum.NONE:
        return AppColor.appColorDark2;
      case ScanStatusEnum.SUCCESS:
        return AppColor.checkedColor;
      case ScanStatusEnum.FAIL:
        return AppColor.appColorDark3;
      case ScanStatusEnum.MISSING:
        return AppColor.appColorOrange3;
      case ScanStatusEnum.DAMAGE:
        return AppColor.errorColor;
      default:
        return AppColor.appColorDark2;
    }
  }
}