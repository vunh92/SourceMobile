import 'package:cooler_mdlz/common/common.dart';
import 'package:flutter/material.dart';

import '../../app/utlis/utils.dart';

enum CheckInStatusEnum {
  CHECKIN,
  CHECKOUT,
  CHECKIN_ERROR,
  CHECKOUT_ERROR,
}

extension HelperCheckInStatucEnum on CheckInStatusEnum {
  String name() {
    switch (this) {
      case CheckInStatusEnum.CHECKIN:
        return 'check-in-success';
      case CheckInStatusEnum.CHECKOUT:
        return 'check-out-success';
      case CheckInStatusEnum.CHECKIN_ERROR:
        return 'check-in-error';
      case CheckInStatusEnum.CHECKOUT_ERROR:
        return 'check-out-error';
      default:
        return AppString.none;
    }
  }
}