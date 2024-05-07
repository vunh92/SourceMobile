import 'dart:convert';
import 'package:cooler_mdlz/model/entities.dart';
import 'package:cooler_mdlz/model/mock_data.dart';
import 'package:cooler_mdlz/view/maintenance/maintenance_page.dart';
import 'package:flutter/material.dart';

import '../app/utlis/utils.dart';
import '../common/common.dart';
import '../service/remote_service.dart';
import 'outlet_detail_controller.dart';

class StockController extends GetxController {
  final OutletDetailController outletDetailController = Get.find<OutletDetailController>();
  var stockCountModel = StockCountModel().obs;
  var planogramPicture = '';
  RxBool isPageLoading = true.obs;
  List<TextEditingController> facesEditControllers = [];
  List<TextEditingController> totalsEditControllers = [];
  bool isReadOnly = true;

  ScrollController controller = ScrollController();

  void animateToIndex(int index) {
    controller.animateTo(
      (180 + NumberConstant.basePaddingLarge*2 + 17)
          + index * (
              NumberConstant.basePaddingLarge
              + NumberConstant.basePaddingMedium*2
              + NumberConstant.basePaddingLarge*2
              + NumberConstant.basePaddingLarge*2
              + 50 + NumberConstant.basePaddingLarge
          )
      ,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void onInit() {
    super.onInit();
    planogramPicture = outletDetailController.coolerModel.value.planogramPicture!.replaceAll(
      RegExp('~'), RemoteServices.host);
    isReadOnly = outletDetailController.selectedOutletDetail == SelectedOutletDetailEnum.VIEW;
  }

  Future<void> bindingData({required int outletId}) async {
    isPageLoading.value = true;
    update();
    await bindingStocks();
    isPageLoading.value = false;
    update();
  }

  bindingStocks() async {
    stockCountModel = outletDetailController.stockCountModel;
    update();
    if(stockCountModel.value.stocks.isNotEmpty) {
      for(var element in stockCountModel.value.stocks) {
        facesEditControllers.add(TextEditingController(
          text: element.faceInput == -1 ? '' : element.faceInput.toString(),
        ));
        totalsEditControllers.add(TextEditingController(
          text: element.totalInput == -1 ? '' :element.totalInput.toString(),
        ));
      }
    }
  }

  updateFace({required int index}) {
    stockCountModel.value.stocks[index].faceInput = facesEditControllers[index].text.isEmpty
        ? -1 : int.parse(facesEditControllers[index].text);
    update();
  }

  updateTotal({required int index}) {
    stockCountModel.value.stocks[index].totalInput = totalsEditControllers[index].text.isEmpty
        ? -1 : int.parse(totalsEditControllers[index].text);
    update();
  }

  Future<int> validatedStock() async {
    if(stockCountModel.value.stocks.isNotEmpty) {
      for(int i = 0; i < stockCountModel.value.stocks.length; i++) {
        if(stockCountModel.value.stocks[i].faceInput == -1 || stockCountModel.value.stocks[i].totalInput == -1) {
          return i;
        }
      }
    }
    return -1;
  }

  saveStep({required bool isUpdate}) async {
    if (outletDetailController.homeController.configModel.value.outletStockCountCheck==1){
      final validated = await validatedStock();
      if(validated > -1) {
        animateToIndex(validated);
        return;
      }
    }
    isPageLoading.value = true;
    update();
    final completedTime = DateTime.now();
    stockCountModel.value.completedTime = completedTime;
    stockCountModel.value.visitDate = completedTime.typeDate();
    if(isUpdate) {
      await SqliteDb.updateRecord(
        tableName: SqliteHelper.tableStockCount,
        maps: stockCountModel.value.toMap(),
        where: ' outletId = ? AND uuid = ? ',
        whereArgs: [stockCountModel.value.outletId, stockCountModel.value.uuid,],
      );
      for (int i = 0; i < stockCountModel.value.stocks.length; i++) {
        await SqliteDb.updateRecord(
          tableName: SqliteHelper.tableStock,
          maps: stockCountModel.value.stocks[i].toMap(),
          where: ' outletId = ? AND stockId = ? AND coolerId = ? AND stockCountId = ? ',
          whereArgs: [
            stockCountModel.value.stocks[i].outletId,
            stockCountModel.value.stocks[i].stockId,
            stockCountModel.value.stocks[i].coolerId,
            stockCountModel.value.stocks[i].stockCountId
          ],
        );
      }
    }else {
      await SqliteDb.insertRecord(
        tableName: SqliteHelper.tableStockCount,
        maps: stockCountModel.value.toMap(),
      );
      for (int i = 0; i < stockCountModel.value.stocks.length; i++) {
        stockCountModel.value.stocks[i].outletId = stockCountModel.value.outletId;
        stockCountModel.value.stocks[i].stockCountId = stockCountModel.value.uuid;
        stockCountModel.value.stocks[i].questionId = stockCountModel.value.questionId;
        stockCountModel.value.stocks[i].questionName = stockCountModel.value.questionName;
        await SqliteDb.insertRecord(
          tableName: SqliteHelper.tableStock,
          maps: stockCountModel.value.stocks[i].toMap(),
        );
      }
    }
    outletDetailController.stockCountModel = stockCountModel;
    outletDetailController.steps[2].status = 1;
    outletDetailController.steps[2].visitDate = completedTime.typeDate();
    outletDetailController.showCheckOutOutlet();
    outletDetailController.update();
    isPageLoading.value = false;
    update();
    Get.offNamed(MaintenancePage.route);
  }

}
