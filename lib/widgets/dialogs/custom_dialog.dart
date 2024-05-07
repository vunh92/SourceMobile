import 'package:cooler_mdlz/common/common.dart';
import 'package:flutter/material.dart';

import '../../app/utlis/utils.dart';

class _Constant {
  static const title = "Thông báo";
  static const message = "Nội dung thông báo";
  static const okLabel = "Đồng ý";
  static const cancelLabel = "Từ chối";
}

class CustomDialog {

  static Widget showOkCancelAlertDialog({
    required BuildContext context,
    String title = _Constant.title,
    String message = _Constant.message,
    String okLabel = _Constant.okLabel,
    String cancelLabel = _Constant.cancelLabel,
  }) {
    OwnThemeFields themeOwn = Theme.of(context).own();
    return AlertDialog(
      title: Text(title.isNotEmpty ? title : _Constant.title),
      content: Text(message.isNotEmpty ? message : _Constant.message),
      actions: <Widget>[
        TextButton(
          child: Text(okLabel, style: TextStyle(color: themeOwn.mainColor),),
          onPressed: () {
            Get.back(result: true);
          },
        ),
        TextButton(
          child: Text(cancelLabel, style: TextStyle(color: themeOwn.mainColor),),
          onPressed: () {
            Get.back(result: false);
          },
        ),
      ],
    );
  }

  static Widget showOkMessage({
    required BuildContext context,
    String title = _Constant.title,
    String message = _Constant.message,
    String okLabel = _Constant.okLabel,
    String cancelLabel = _Constant.cancelLabel,
  }) {
    OwnThemeFields themeOwn = Theme.of(context).own();
    return AlertDialog(
      title: Text(title.isNotEmpty ? title : _Constant.title),
      content: Text(message.isNotEmpty ? message : _Constant.message),
      actions: <Widget>[
        TextButton(
          child: Text(okLabel, style: TextStyle(color: themeOwn.mainColor),),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }

}