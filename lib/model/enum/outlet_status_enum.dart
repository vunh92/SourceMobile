import 'package:cooler_mdlz/common/common.dart';
import 'package:flutter/material.dart';

import '../../app/utlis/utils.dart';

enum OutletStatusEnum {
  CHECKED,
  UNCHECKED,
  INPROGRESS,
  WRONG_LOCATION,
}

extension HelperOutletStatusEnum on OutletStatusEnum {
  String name() {
    switch (this) {
      case OutletStatusEnum.CHECKED:
        return AppString.checked;
      case OutletStatusEnum.UNCHECKED:
        return AppString.unChecked;
      case OutletStatusEnum.INPROGRESS:
        return AppString.inProgress;
      case OutletStatusEnum.WRONG_LOCATION:
        return AppString.wrongLocation;
      default:
        return AppString.none;
    }
  }

  Color color() {
    switch (this) {
      case OutletStatusEnum.CHECKED:
        return AppColor.checkedColor;
      case OutletStatusEnum.UNCHECKED:
        return AppColor.appColorDark2;
      case OutletStatusEnum.INPROGRESS:
        return AppColor.inProgressColor;
      case OutletStatusEnum.WRONG_LOCATION:
        return AppColor.errorColor;
      default:
        return AppColor.appColorDark2;
    }
  }
}