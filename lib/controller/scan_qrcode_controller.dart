import 'package:cooler_mdlz/common/common.dart';
import 'package:cooler_mdlz/model/entities.dart';
import 'package:flutter/material.dart';

import '../app/utlis/utils.dart';
import '../view/hotzone/hotzone_page.dart';
import 'outlet_detail_controller.dart';

class ScanQrcodeController extends GetxController {
  final OutletDetailController outletDetailController = Get.find<OutletDetailController>();

  var scanQrcodeModel = ScanQrcodeModel().obs;
  var noteEditController = TextEditingController();
  ScanStatusEnum scanStatus = ScanStatusEnum.NONE;
  RxBool isPageLoading = true.obs;
  bool isReadOnly = true;
  var reScan = false.obs;
  @override
  void onInit() {
    super.onInit();
    isReadOnly = outletDetailController.selectedOutletDetail == SelectedOutletDetailEnum.VIEW;
  }

  checkScan({String qrcode = ''}) async {
    reScan.value=false;
    scanQrcodeModel.value.scanCode = qrcode;
    scanStatus = qrcode == scanQrcodeModel.value.coolerModel?.serialNumber ? ScanStatusEnum.SUCCESS : ScanStatusEnum.FAIL;
    scanQrcodeModel.value.isScan = true;
    scanQrcodeModel.value.assetStatus = scanStatus == ScanStatusEnum.SUCCESS ? 4 : 3;
    update();
  }

  cannotScan({required int reason}) async {
    reScan.value=false;
    scanQrcodeModel.value.isScan = true;
    scanStatus = reason == 1 ? ScanStatusEnum.MISSING : ScanStatusEnum.DAMAGE;
    scanQrcodeModel.value.assetStatus = scanStatus == ScanStatusEnum.MISSING ? 2 : 1;
    scanQrcodeModel.value.scanCode = scanStatus.name();
    update();
  }

  Future<void> bindingData({int outletId = 0}) async {
    isPageLoading.value = true;
    update();
    scanQrcodeModel.value = outletDetailController.scanQrcodeModel.value;
    scanStatus = setAssetStatus(num: scanQrcodeModel.value.assetStatus ?? 0);
    noteEditController.text = scanQrcodeModel.value.note ?? '';
    isPageLoading.value = false;
    update();
  }

  setAssetStatus({int num = 0}) {
    switch (num) {
      case 4:
        return ScanStatusEnum.SUCCESS;
      case 3:
        return ScanStatusEnum.FAIL;
      case 2:
        return ScanStatusEnum.MISSING;
      case 1:
        return ScanStatusEnum.DAMAGE;
      default:
        return ScanStatusEnum.NONE;
    }
  }

  saveStep({required bool isUpdate}) async {
    isPageLoading.value = true;
    scanQrcodeModel.value.note = noteEditController.text;
    final completedTime = DateTime.now();
    scanQrcodeModel.value.completedTime = completedTime;
    scanQrcodeModel.value.visitDate = completedTime.typeDate();
    update();
    if(isUpdate) {
      await SqliteDb.updateRecord(
        tableName: SqliteHelper.tableScan,
        maps: scanQrcodeModel.value.toMap(),
        where: ' outletId = ? AND uuid = ? ',
        whereArgs: [scanQrcodeModel.value.outletId, scanQrcodeModel.value.uuid],
      );
    }else {
      await SqliteDb.insertRecord(
        tableName: SqliteHelper.tableScan,
        maps: scanQrcodeModel.value.toMap(),
      );
    }
    outletDetailController.scanQrcodeModel = scanQrcodeModel;
    outletDetailController.steps[0].status = 1;
    outletDetailController.steps[0].visitDate = completedTime.typeDate();
    outletDetailController.scanCoolerMissing.value = scanQrcodeModel.value.assetStatus! == 2;
    outletDetailController.update();
    outletDetailController.showCheckOutOutlet();
    isPageLoading.value = false;
    update();
    await outletDetailController.homeController.refreshOutletWithID(id: outletDetailController.outletDetail.value.outletId??0);
    if(outletDetailController.scanCoolerMissing.value) {
      Get.back();
    }else {
      Get.offNamed(HotzonePage.route);
    }
  }

}
