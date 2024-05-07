import 'dart:convert';
import 'dart:io';

import 'package:cooler_mdlz/common/common.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../model/entities.dart';
import '../app/utlis/utils.dart';
import '../service/connection/connection_status_singleton.dart';
import '../service/remote_service.dart';
import '../view/hotzone/hotzone_page.dart';
import '../view/maintenance/maintenance_page.dart';
import '../view/qrcode/scan_qrcode_page.dart';
import '../view/stock_count/stock_page.dart';
import 'home_controller.dart';

class _Constant {
  static const checkInFail = "Check-In thất bại!";
  static const checkOutFail = "Check-Out thất bại!";
  static const overDistance = "Vượt quá khoảng cách";
  static const loadDataLocal = "Bạn có muốn lưu dữ liệu trong máy không?";
  static const noCooler = "Không tìm thấy cooler ở cửa hàng này!";
  static const noStocks = "Cửa hàng chưa cài đặt sản phẩm!";
  static const checkOutSuccess = "${AppString.checkOut} thành công";
  static const checkOutAnotherDate = "Vui lòng CHECK-OUT trong ngày!";

}

class OutletDetailController extends GetxController {
  var coolerModel = CoolerModel().obs;
  var surveyModel = SurveyModel().obs;
  var outletDetail = OutletDetailModel().obs;

  var scanQrcodeModel = ScanQrcodeModel().obs;
  var hotZoneModel = HotZoneModel().obs;
  var stockCountModel = StockCountModel().obs;
  var maintenanceModel = MaintenanceModel().obs;
  var steps = <StepModel>[].obs;

  var checkOutResponse = OutletCheckOutResponse();

  var coolerMissing = false.obs;
  var scanCoolerMissing = false.obs;
  var outletPicture = '';

  SelectedOutletDetailEnum selectedOutletDetail = SelectedOutletDetailEnum.NONE;
  RxBool isPageLoading = true.obs;
  RxBool validatedCheckout = false.obs;
  HomeController homeController = Get.find<HomeController>();
  late ConnectionStatusSingleton connectionStatusSingleton;
  double distance = -1;

  @override
  void onInit()  {
    super.onInit();
    connectionStatusSingleton = ConnectionStatusSingleton.getInstance();
    outletPicture = homeController.configModel.value.outletPicture!.replaceAll(
        RegExp('~'), RemoteServices.host);
  }

  selectedStep(String step) async {
    switch (step) {
      case '1':
        Get.toNamed(ScanQrcodePage.route);
        break;
      case '2':
        Get.toNamed(HotzonePage.route);
        break;
      // case '3':
      //   Get.toNamed(StockPage.route);
      //   break;
      case '3':
        Get.toNamed(MaintenancePage.route);
        break;
    }
  }

  bindingData({
    required OutletModel outletModel
  }) async {
    isPageLoading.value = true;
    update();
    await bindingOutletDetail();
    await bindingStep();
    if (outletDetail.value.currentStatus=="check-in-success") {
      await getSurveyApi();
    }
    if (outletDetail.value.currentStatus=="check-in-success" || outletDetail.value.currentStatus=="check-out-success")
    {
        await getCoolerApi( false);
        if(selectedOutletDetail != SelectedOutletDetailEnum.VIEW ){
          if(coolerModel.value.serialNumber?.isEmpty ?? true) {
            isPageLoading.value = false;
            update();
            return;
          }
          if(coolerModel.value.stocks.isEmpty && homeController.configModel.value.outletStockCountCheck == 1) {
            isPageLoading.value = false;
            update();
            return;
          }
        }

    }


    if (outletDetail.value.currentStatus=="check-in-success" || selectedOutletDetail == SelectedOutletDetailEnum.REVISIT) {
      await getSurveyApi();
    }

    if(selectedOutletDetail == SelectedOutletDetailEnum.VIEW && (outletModel.checkListData?.isNotEmpty ?? false)) {
      outletDetail.value.completedTime = outletModel.checkOutDate;
      checkOutResponse = outletModel.checkListData!.last;
      await getCheckListData();
    }else {
      await getOutletDetailBinding();
    }

    showCheckOutOutlet();
    isPageLoading.value = false;
    update();
  }

  /// VIEW OUTLET
  getCheckListData() async {
    await setDataScan();
    await setDataHotZone();
    // await setDataStockCount();
    await setDataMaintenance();
  }

  setDataScan() async {
    scanQrcodeModel.value = checkOutResponse.mapScanQrcodeModel(
        outletDetail: outletDetail.value,
        cooler: coolerModel.value
    );
    if(checkOutResponse.scanSerialNumber?.isNotEmpty ?? false) {
      scanQrcodeModel.value.visitDate = checkOutResponse.checkOutDate?.typeDate();
      steps[0].status = 1;
      steps[0].visitDate = checkOutResponse.checkOutDate?.typeDate();
    }
    update();
  }

  setDataHotZone() async {
    hotZoneModel.value = checkOutResponse.mapHotZoneModel(
      outletDetail: outletDetail.value,
      survey: surveyModel.value,
    );
    final questions = checkOutResponse.surveyResult.map((e) {
      final surveyQuestions = surveyModel.value.questions.where((element) => element.questionId.toString() == e.questionId);
      SurveyQuestionModel? surveyQuestion = surveyQuestions.isNotEmpty ? surveyQuestions.first : null;
      final question = e.mapSurveyQuestionModel(
        outletId: outletDetail.value.outletId!,
        surveyId: surveyModel.value.id!,
        displayOrder: surveyQuestion?.displayOrder ?? 0,
      );
      return question;
    }).toList();
    hotZoneModel.value.surveys.first.questions = questions;
    if(checkOutResponse.hotZoneCompletedTime != null) {
      hotZoneModel.value.visitDate = checkOutResponse.checkOutDate?.typeDate();
      steps[1].status = 1;
      steps[1].visitDate = checkOutResponse.checkOutDate?.typeDate();
    }
    update();
  }

  /*setDataStockCount() async {
    stockCountModel.value = checkOutResponse.mapStockCountModel(
      survey: surveyModel.value,
      cooler: coolerModel.value,
    );
    final stocks = stockCountModel.value.stocks.map((e) {
      final stockResponses = checkOutResponse.stocks.where((element) => element.stockId == e.stockId);
      StockResponse? stockResponse = stockResponses.isNotEmpty ? stockResponses.first : null;
      e.faceInput = stockResponse?.face ?? e.face;
      e.totalInput = stockResponse?.total ?? e.total;
      update();
      return e;
    }).toList();
    stockCountModel.value.stocks = stocks;
    if(checkOutResponse.stockCountCompletedTime != null) {
      stockCountModel.value.visitDate = checkOutResponse.checkOutDate?.typeDate();
      steps[2].status = 1;
      steps[2].visitDate = checkOutResponse.checkOutDate?.typeDate();
    }
    update();
  }*/

  setDataMaintenance() async {
    maintenanceModel.value = checkOutResponse.mapMaintenanceModel();
    if((checkOutResponse.maintenanceDescription?.isNotEmpty ?? false)
        || (checkOutResponse.maintenancePicture1?.isNotEmpty ?? false)) {
      maintenanceModel.value.visitDate = checkOutResponse.checkOutDate?.typeDate();
      steps[2].status = 1;
      steps[2].visitDate = checkOutResponse.checkOutDate?.typeDate();
    }
    update();
  }

  /// RE-VISIT or NEW VISIT
  getOutletDetailBinding() async {
    await bindingScan(visitDate: DateTime.now());
    await bindingHotZone(visitDate: DateTime.now());
    // await bindingStockCount(visitDate: DateTime.now());
    await bindingMaintenance(visitDate: DateTime.now());
  }

  bindingScan({ required DateTime visitDate,}) async {
    final scans = await SqliteDb.getRecords(
      tableName: SqliteHelper.tableScan,
      where: ' outletId = ? AND visitDate = ? ',
      whereArgs: [outletDetail.value.outletId!, visitDate.typeDate().toString()],
      limit: 1,
    );
    if (scans.isNotEmpty) {
      scanQrcodeModel.value = ScanQrcodeModel.generate(scans.first, coolerModel: coolerModel.value);
      scanCoolerMissing.value = scanQrcodeModel.value.assetStatus! == 2;
      if(scanQrcodeModel.value.visitDate != null) {
        steps[0].status = 1;
        steps[0].visitDate = scanQrcodeModel.value.visitDate;
      }
    } else {
      scanQrcodeModel.value = ScanQrcodeModel.bindingData(
        outletId: outletDetail.value.outletId ?? 0,
        coolerModel: coolerModel.value,
      );
    }
  }

  bindingHotZone({required DateTime visitDate}) async {
    final hotZones = await SqliteDb.getRecords(
      tableName: SqliteHelper.tableHotZone,
      where: ' outletId = ? AND visitDate = ? ',
      whereArgs: [outletDetail.value.outletId!, visitDate.typeDate().toString()],
      limit: 1,
    );
    if (hotZones.isNotEmpty) {
      hotZoneModel.value = HotZoneModel.generate(hotZones.first);
      if(hotZoneModel.value.visitDate != null) {
        steps[1].status = 1;
        steps[1].visitDate = hotZoneModel.value.visitDate;
      }
    } else {
      hotZoneModel.value = HotZoneModel.bindingData(outletId: outletDetail.value.outletId!);
    }
    hotZoneModel.value.surveys = [surveyModel.value];
    final questionRecords = await SqliteDb.getRecords(
      tableName: SqliteHelper.tableQuestion,
      where: ' outletId = ? AND hotZoneId = ? ',
      whereArgs: [outletDetail.value.outletId!, hotZoneModel.value.uuid],
    );
    if(questionRecords.isNotEmpty) {
      hotZoneModel.value.surveys.first.questions = questionRecords.map((e) => SurveyQuestionModel.generate(e)).toList();
    }
  }

  /*bindingStockCount({required DateTime visitDate}) async {
    final stockCountRecords = await SqliteDb.getRecords(
      tableName: SqliteHelper.tableStockCount,
      where: ' outletId = ? AND visitDate = ? ',
      whereArgs: [outletDetail.value.outletId!, visitDate.typeDate().toString()],
      limit: 1,
    );
    if (stockCountRecords.isNotEmpty) {
      stockCountModel.value = StockCountModel.generate(stockCountRecords.first);
      if(stockCountModel.value.visitDate != null) {
        steps[2].status = 1;
        steps[2].visitDate = stockCountModel.value.visitDate;
      }
    } else {
      stockCountModel.value = StockCountModel.bindingData(
        outletId: outletDetail.value.outletId!,
        survey: surveyModel.value,
        stocks: coolerModel.value.stocks,
      );
    }
    final stockRecords = await SqliteDb.getRecords(
      tableName: SqliteHelper.tableStock,
      where: ' outletId = ? AND stockCountId = ? ',
      whereArgs: [outletDetail.value.outletId!, stockCountModel.value.uuid],
    );
    if(stockRecords.isNotEmpty) {
      stockCountModel.value.stocks = stockRecords.map((e) => StockModel.generate(e)).toList();
    }
  }*/

  bindingMaintenance({required DateTime visitDate}) async {
    final maintenances = await SqliteDb.getRecords(
      tableName: SqliteHelper.tableMaintenance,
      where: ' outletId = ? AND visitDate = ? ',
      whereArgs: [outletDetail.value.outletId!, visitDate.typeDate().toString()],
      limit: 1,
    );
    if (maintenances.isNotEmpty) {
      maintenanceModel.value = MaintenanceModel.generate(maintenances.first);
      if(maintenanceModel.value.visitDate != null) {
        steps[2].status = 1;
        steps[2].visitDate = maintenanceModel.value.visitDate;
      }
    }else {
      maintenanceModel.value = MaintenanceModel.bindingData(outletId: outletDetail.value.outletId!);
    }
  }

  updateOutlet() async {
    try {
      homeController.allOutlets[homeController.allOutlets.indexWhere(
              (e) => e.id == homeController.outletModel.value.id!)] =
          homeController.outletModel.value;
      homeController.checkedOutlets.value =
         await homeController.getCheckedList();
      if(homeController.todayOutlets.isNotEmpty) {
        homeController.todayOutlets[homeController.todayOutlets.indexWhere(
              (e) => e.id == homeController.outletModel.value.id!)] =
          homeController.outletModel.value;
        homeController.unCheckedOutlets.value =
            homeController.getUnCheckedList(list: homeController.todayOutlets);
      }
      homeController.update();
    }catch (e) {}
  }

  checkInOutlet() async {
    isPageLoading.value = true;
    update();
    if (await connectionStatusSingleton.checkConnection() == false) {
      isPageLoading.value = false;
      update();
      var result = await showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {
          return const NoInternetDialog(error: ErrorConnectedEnum.WIFI,);
        },
      );
      return;
    }
    LatLng? currentLocation;
    await getCurrentLocation().then((value) async {
      currentLocation = LatLng(value.latitude, value.longitude);
    });
    if(currentLocation == null) {
      isPageLoading.value = false;
      update();
      final result = await Get.dialog(const WrongLocationDialog());
      return;
    }else {
      distance = Utils.getDistance(
        latStart: currentLocation!.latitude, longStart: currentLocation!.longitude,
        latEnd: outletDetail.value.lat!, longEnd: outletDetail.value.long!,
      );
      outletDetail.value.distance = distance;
      update();
    }
    bool overDistance = distance > homeController.configModel.value.distance!;
    var resCheckInOutlet = await OutletService.fetchCheckInOutlet(
      deviceId: homeController.deviceModel.value.deviceId!,
      outletId: outletDetail.value.outletId!,
      currentStatus: overDistance ? CheckInStatusEnum.CHECKIN_ERROR.name() : CheckInStatusEnum.CHECKIN.name(),
      checkInText: overDistance ? _Constant.overDistance : '',
      checkoutStatus:overDistance ? 1 : 0,
      distance: distance,
      visitDate: homeController.selectedDate.value.toStringWithFormat(format: 'yyyy-MM-dd') ?? '',
    );
    if(resCheckInOutlet.statusCode == 200) {
      final response = OutletDetailCheckIn.mapFromJson(jsonDecode(resCheckInOutlet.body));
      if(response.checkInId!.isNotEmpty) {
        try {
          outletDetail.value.checkInDate = response.checkInDate;
          outletDetail.value.checkInTime = response.checkInTime;
          outletDetail.value.checkInId = response.checkInId;
          outletDetail.value.currentStatus = response.currentStatus;
          outletDetail.value.code = response.outletCode;

          // Update outlet
          homeController.outletModel.value.checkInDate = response.checkInDate;
          homeController.outletModel.value.checkInTime = response.checkInTime;
          homeController.outletModel.value.checkInId = response.checkInId;
          homeController.outletModel.value.currentStatus = response.currentStatus;
          homeController.outletModel.value.code = response.outletCode;
          if( outletDetail.value.currentStatus=="check-in-success"){
            await getSurveyApi();
            await getCoolerApi(true);
            await getOutletDetailBinding();
          }

          update();
          homeController.update();
          final checkIns = await SqliteDb.getRecords(
            tableName: SqliteHelper.tableOutletDetail,
            where: ' outletId = ? AND visitDate = ? ',
            whereArgs: [outletDetail.value.outletId!, response.checkInDate?.typeDate().toString()],
            limit: 1,
          );
          outletDetail.value.completedTime = response.checkInDate;
          outletDetail.value.visitDate = response.checkInDate?.typeDate();
          if(checkIns.isNotEmpty) {
            final updateCheckIn = await SqliteDb.updateRecord(
              tableName: SqliteHelper.tableOutletDetail,
              maps: outletDetail.value.toMapCheckIn(
                checkIn: response,
                cooler: coolerModel.value,
              ),
              where: ' outletId = ? AND uuid = ? ',
              whereArgs: [outletDetail.value.outletId, outletDetail.value.uuid],
            );
          }else {
            final insertCheckIn = await SqliteDb.insertRecord(
              tableName: SqliteHelper.tableOutletDetail,
              maps: outletDetail.value.toMapCheckIn(
                checkIn: response,
                cooler: coolerModel.value,
              ),
            );
          }
          updateOutlet();
          isPageLoading.value = false;
          update();
          if(overDistance) {
            final result = await Get.dialog(const WrongLocationDialog());
            Get.back();
          }
        } catch (ex) {
          isPageLoading.value = false;
          update();
          print(ex.toString());
        }
      }else {
        await Get.dialog(CustomDialog.showOkMessage(
          context: Get.context!,
          message: _Constant.checkInFail,
        ));
        isPageLoading.value = false;
        update();
      }
    }else {
      isPageLoading.value = false;
      update();
      await Get.dialog(CustomDialog.showOkMessage(
        context: Get.context!,
        message: _Constant.checkInFail,
      ));
    }
  }

  getCoolerApi( bool showAlert) async {
    if (await connectionStatusSingleton.checkConnection() == false) {
      if(homeController.allCoolers.where((p0) => p0.outletId==(homeController.outletModel.value.id ?? 0)).isNotEmpty)
        {
          coolerModel.value =  homeController.allCoolers.where((p0) => p0.outletId==(homeController.outletModel.value.id ?? 0)).first;
          coolerModel.value.stocks = coolerModel.value.stocks.map((e) {
            e.outletId = homeController.outletModel.value.id;
            return e;
          }).toList();
          coolerMissing.value=false;
          return;
        }
      coolerMissing.value=true;
      await showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {
          return const NoInternetDialog(error: ErrorConnectedEnum.WIFI,);
        },
      );
      return;
    }else {
      var resCooler = await OutletService.fetchOutletCooler(
        deviceId: homeController.deviceModel.value.deviceId!,
        outletId: homeController.outletModel.value.id ?? 0,
      );
      if (resCooler.statusCode == 200) {
        try {
          final responseCooler = CoolerResponse.mapFromJson(jsonDecode(resCooler.body));
          if (responseCooler != null) {
            coolerModel.value = responseCooler.coolers.first;
            coolerModel.value.stocks = responseCooler.coolers.first.stocks.map((e) {
              e.outletId = homeController.outletModel.value.id;
              return e;
            }).toList();
            if(homeController.allCoolers.where((p0) => p0.id==(coolerModel.value.id ?? 0)).isNotEmpty) {
              homeController.allCoolers.remove(homeController.allCoolers.where((p0) => p0.id==(coolerModel.value.id ?? 0)).first);
            }
            homeController.allCoolers.add(responseCooler.coolers.first);
            coolerMissing.value=false;
          }else{
            coolerMissing.value=true;
          }
        } catch (ex) {
          isPageLoading.value = false;
          update();
          coolerMissing.value=true;
          if(selectedOutletDetail != SelectedOutletDetailEnum.VIEW ){
            if(showAlert)
              {
                await Get.dialog(CustomDialog.showOkMessage(
                  context: Get.context!,
                  message: _Constant.noCooler,
                ));
              }

          }

          return;
        }
      }
    }
  }

  getSurveyApi() async {
    if (await connectionStatusSingleton.checkConnection() == false) {

      if(homeController.allSurvey.where((p0) => p0.id==(homeController.outletModel.value.surveyId ?? 0)).isNotEmpty)
      {
        surveyModel.value =  homeController.allSurvey.where((p0) => p0.id==(homeController.outletModel.value.surveyId ?? 0)).first;
        surveyModel.value.questions = surveyModel.value.questions.map((e) {
          e.outletId = homeController.outletModel.value.id;
          return e;
        }).toList();
        return;
      }

      await showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {
          return const NoInternetDialog(error: ErrorConnectedEnum.WIFI,);
        },
      );
      return;
    }else {
      var resSurvey = await OutletService.fetchOutletSurvey(
        deviceId: homeController.deviceModel.value.deviceId!,
        outletId: homeController.outletModel.value.id ?? 0,
      );
      if (resSurvey.statusCode == 200) {
        try {
          final responseSurvey = SurveyModel.mapFromJson(jsonDecode(resSurvey.body));
          if (responseSurvey != null) {
            surveyModel.value = responseSurvey;
            surveyModel.value.questions = surveyModel.value.questions.map((e) {
              e.outletId = homeController.outletModel.value.id;
              return e;
            }).toList();
            if(homeController.allSurvey.where((p0) => p0.id==(homeController.outletModel.value.surveyId ?? 0)).isNotEmpty){
              homeController.allSurvey.remove(homeController.allSurvey.where((p0) => p0.id==(homeController.outletModel.value.surveyId ?? 0)).first);
            }
            homeController.allSurvey.add(surveyModel.value);

          }
        } catch (ex) {
          printError(info: ex.toString());
        }
      }
    }
  }

  bindingOutletDetail() async {
    final details = await SqliteDb.getRecords(
      tableName: SqliteHelper.tableOutletDetail,
      where: ' outletId = ? And visitDate = ? ',
      whereArgs: [homeController.outletModel.value.id ?? 0, homeController.outletModel.value.checkInDate.toString()],
      limit: 1,
    );
    if(details.isNotEmpty) {
      outletDetail.value = OutletDetailModel.generate(details.first, outlet: homeController.outletModel.value);
    }else {
      outletDetail.value = OutletDetailModel.bindingData(outlet: homeController.outletModel.value);
    }
  }

  bindingStep() async {
    steps.value = StepModel.newSteps(
      outletId: homeController.outletModel.value.id ?? 0,
      visitDate: null,
      outletHotZoneCheck: homeController.configModel.value.outletHotZoneCheck ?? 0,
      outletStockCountCheck: homeController.configModel.value.outletStockCountCheck ?? 0,
    );
  }

  showCheckOutOutlet() {
    bool result = true;
    for (int i = 0; i < steps.length-1; i++) {
      if(steps[i].status != 1) result = false;
    }
    validatedCheckout.value = (result || scanCoolerMissing.value);
    update();
  }

  Future<Position> getCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
    });
    return await Geolocator.getCurrentPosition();
  }

  checkOutOutlet() async {
    isPageLoading.value = true;
    update();
    if (await connectionStatusSingleton.checkConnection() == false) {
      isPageLoading.value = false;
      update();
      await showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {
          return const NoInternetDialog(error: ErrorConnectedEnum.WIFI,);
        },
      );
      return;
    }
    LatLng? currentLocation;
    double distance = -1;
    await getCurrentLocation().then((value) async {
      currentLocation = LatLng(value.latitude, value.longitude);
    });
    if(currentLocation == null) {
      isPageLoading.value = false;
      update();
      final result = await Get.dialog(const WrongLocationDialog());
      return;
    }else {
      distance = Utils.getDistance(
          latStart: currentLocation!.latitude, longStart: currentLocation!.longitude,
          latEnd: outletDetail.value.lat!, longEnd: outletDetail.value.long!,
      );
      outletDetail.value.distance = distance;
      update();
    }
    final anotherDate = outletDetail.value.checkInDate?.typeDate().compareTo(DateTime.now().typeDate()) != 0;
    if(anotherDate) {
      isPageLoading.value = false;
      update();
      await Get.dialog(CustomDialog.showOkMessage(
        context: Get.context!,
        message: _Constant.checkOutAnotherDate,
      ));
      await clearDataLocal();
      homeController.refreshOutlet();
      Get.back();
      return;
    }
    try {
      if(File(hotZoneModel.value.hotZonePictureLocal!).existsSync()) {
        final resHotZonePicture = await OutletService.fetchUploadFile(
          filePath: hotZoneModel.value.hotZonePictureLocal!,);
        if (resHotZonePicture.statusCode == 200) {
          hotZoneModel.value.hotZonePicture = resHotZonePicture.data['Url'] ?? '';
          update();
          await SqliteDb.updateRecord(
            tableName: SqliteHelper.tableHotZone,
            maps: {'hotZonePicture': hotZoneModel.value.hotZonePicture},
            where: ' outletId = ? AND uuid = ?',
            whereArgs: [hotZoneModel.value.outletId, hotZoneModel.value.uuid],
          );
        }
      }
    }catch (ex) {}
    try {
      if(File(hotZoneModel.value.planogramPictureLocal!).existsSync()) {
        final resPlanogramPicture = await OutletService.fetchUploadFile(
          filePath: hotZoneModel.value.planogramPictureLocal!,);
        if (resPlanogramPicture.statusCode == 200) {
          hotZoneModel.value.planogramPicture = resPlanogramPicture.data['Url'] ?? '';
          update();
          await SqliteDb.updateRecord(
            tableName: SqliteHelper.tableHotZone,
            maps: {'planogramPicture': hotZoneModel.value.planogramPicture},
            where: ' outletId = ? AND uuid = ?',
            whereArgs: [hotZoneModel.value.outletId, hotZoneModel.value.uuid],
          );
        }
      }
    }catch (ex) {}
    try {
      if(File(maintenanceModel.value.maintenancePicture1Local ?? '').existsSync()) {
        final resMaintenancePicture = await OutletService.fetchUploadFile(
            filePath: maintenanceModel.value.maintenancePicture1Local!);
        if (resMaintenancePicture.statusCode == 200) {
          maintenanceModel.value.maintenancePicture1 = resMaintenancePicture.data['Url'] ?? '';
          await SqliteDb.updateRecord(
            tableName: SqliteHelper.tableMaintenance,
            maps: {'maintenancePicture1': maintenanceModel.value.maintenancePicture1},
            where: ' outletId = ? AND uuid = ?',
            whereArgs: [maintenanceModel.value.outletId, maintenanceModel.value.uuid],
          );
        }
      }
    }catch (ex) {}
    try {
      if(File(maintenanceModel.value.maintenancePicture2Local ?? '').existsSync()) {
        final resMaintenancePicture = await OutletService.fetchUploadFile(
            filePath: maintenanceModel.value.maintenancePicture2Local!);
        if (resMaintenancePicture.statusCode == 200) {
          maintenanceModel.value.maintenancePicture2 = resMaintenancePicture.data['Url'] ?? '';
          await SqliteDb.updateRecord(
            tableName: SqliteHelper.tableMaintenance,
            maps: {'maintenancePicture2': maintenanceModel.value.maintenancePicture2},
            where: ' outletId = ? AND uuid = ?',
            whereArgs: [maintenanceModel.value.outletId, maintenanceModel.value.uuid],
          );
        }
      }
    }catch (ex) {}
    try {
      if(File(maintenanceModel.value.maintenancePicture3Local ?? '').existsSync()) {
        final resMaintenancePicture = await OutletService.fetchUploadFile(
            filePath: maintenanceModel.value.maintenancePicture3Local!);
        if (resMaintenancePicture.statusCode == 200) {
          maintenanceModel.value.maintenancePicture3 = resMaintenancePicture.data['Url'] ?? '';
          await SqliteDb.updateRecord(
            tableName: SqliteHelper.tableMaintenance,
            maps: {'maintenancePicture3': maintenanceModel.value.maintenancePicture3},
            where: ' outletId = ? AND uuid = ?',
            whereArgs: [maintenanceModel.value.outletId, maintenanceModel.value.uuid],
          );
        }
      }
    }catch (ex) {}
    var cStatus=ScanStatusEnum.SUCCESS.name();
    if(coolerMissing.value){
      cStatus="Chưa thiết lập";
    }else{
      if(scanQrcodeModel.value.assetStatus==1){
        cStatus=ScanStatusEnum.DAMAGE.name();
      }
      else if(scanQrcodeModel.value.assetStatus==2){
        cStatus=ScanStatusEnum.MISSING.name();
      }
      else if(scanQrcodeModel.value.assetStatus==3){
        cStatus=ScanStatusEnum.FAIL.name();
      }
    }

    var checkOutText= ScanStatusEnum.SUCCESS.name();

    if(coolerMissing.value){
      checkOutText="Chưa thiết lập";
    }else{
      if(scanQrcodeModel.value.assetStatus==1){
        checkOutText=ScanStatusEnum.DAMAGE.name();
      }
      else if(scanQrcodeModel.value.assetStatus==2){
        checkOutText=ScanStatusEnum.MISSING.name();
      }
      else if(scanQrcodeModel.value.assetStatus==3){
        checkOutText=ScanStatusEnum.FAIL.name();
      }
    }
    final checkOut = OutletDetailCheckOut(
      coolerId: coolerModel.value.id,
      outletId: outletDetail.value.outletId,
      scanCode: scanQrcodeModel.value.scanCode,
      checkInId:outletDetail.value.checkInId,
      hotZonePicture: hotZoneModel.value.hotZonePicture,
      planogramPicture: hotZoneModel.value.planogramPicture,
      hotZoneCompletedTime: coolerMissing.value?null:hotZoneModel.value.completedTime?.toStringWithFormat(format: 'yyyy-MM-ddThh:mm:ss') ?? '',
      stockCountCompletedTime: coolerMissing.value?null:stockCountModel.value.completedTime?.toStringWithFormat(format: 'yyyy-MM-ddThh:mm:ss') ?? '',
      currentStatus: outletDetail.value.currentStatus,
      coolerStatus:cStatus,
      checkOutText:checkOutText ,
      checkoutStatus:coolerMissing.value?2:(cStatus!=ScanStatusEnum.SUCCESS.name()?(cStatus!=ScanStatusEnum.MISSING.name()?3:2):4),
      qrNote: scanQrcodeModel.value.note,
      maintenancePicture1: maintenanceModel.value.maintenancePicture1,
      maintenancePicture2: maintenanceModel.value.maintenancePicture2,
      maintenancePicture3: maintenanceModel.value.maintenancePicture3,
      maintenanceDescription: maintenanceModel.value.description,
      questions: coolerMissing.value?[]: hotZoneModel.value.surveys.first.questions.map((question) {
        return QuestionRequest.mapFromQuestion(questionModel: question);
      }).toList(),
      stocks: coolerMissing.value?[]: stockCountModel.value.stocks.map((stock) {
        return StockRequest.mapFromStock(stock: stock, questionType: surveyModel.value.questions.first.answerType.toString());
      }).toList(),
      outletHotZoneCheck: homeController.configModel.value.outletHotZoneCheck,
      outletStockCountCheck: homeController.configModel.value.outletStockCountCheck,
    );
    var bodyCheckOut = checkOut.toBodyCheckOut(deviceId: homeController.deviceModel.value.deviceId ?? '', distance: distance);
    final encord = jsonEncode(bodyCheckOut);
    final responseCheckOut = await OutletService.fetchCheckOutOutlet(body: bodyCheckOut);
    update();
    if(responseCheckOut.statusCode == 200) {
      final responseSurvey = OutletCheckOutResponse.fromJsonApi(jsonDecode(responseCheckOut.body));
      // Update outlet
      outletDetail.value.currentStatus = responseSurvey.currentStatus ?? '';
      outletDetail.value.coolerStatus = responseSurvey.coolerStatus ?? '';
      outletDetail.value.checkOutStatus = responseSurvey.checkOutStatus ?? 0;
      outletDetail.value.checkOutDate = responseSurvey.checkOutDate;
      outletDetail.value.checkOutTime = responseSurvey.checkOutTime;
      update();
      homeController.outletModel.value.currentStatus = responseSurvey.currentStatus ?? '';
      homeController.outletModel.value.checkOutDate = responseSurvey.checkOutDate;
      homeController.outletModel.value.checkOutTime = responseSurvey.checkOutTime;
      homeController.outletModel.value.checkListData = [responseSurvey];
      if(homeController.outletModel.value.countCheckoutSuccess == 0) {
        homeController.outletModel.value.countCheckoutSuccess = 1;
      }
      homeController.update();
      await updateOutlet();
      await clearDataLocal();
      isPageLoading.value = false;
      update();
      SnackHelper.showMessage(context: Get.context!, message: _Constant.checkOutSuccess);
      Get.back();
    }else {
      isPageLoading.value = false;
      update();
      await Get.dialog(CustomDialog.showOkMessage(
        context: Get.context!,
        message: _Constant.checkOutFail,
      ));
    }
    isPageLoading.value = false;
    update();
  }

  checkOutMissingCooler() async {
    isPageLoading.value = true;
    update();
    if (await connectionStatusSingleton.checkConnection() == false) {
      isPageLoading.value = false;
      update();
      await showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {
          return const NoInternetDialog(error: ErrorConnectedEnum.WIFI,);
        },
      );
      return;
    }
    LatLng? currentLocation;
    double distance = -1;
    await getCurrentLocation().then((value) async {
      currentLocation = LatLng(value.latitude, value.longitude);
    });
    if(currentLocation == null) {
      isPageLoading.value = false;
      update();
      final result = await Get.dialog(const WrongLocationDialog());
      return;
    }else {
      distance = Utils.getDistance(
        latStart: currentLocation!.latitude, longStart: currentLocation!.longitude,
        latEnd: outletDetail.value.lat!, longEnd: outletDetail.value.long!,
      );
      outletDetail.value.distance = distance;
      update();
    }
    final anotherDate = outletDetail.value.checkInDate?.typeDate().compareTo(DateTime.now().typeDate()) != 0;
    if(anotherDate) {
      isPageLoading.value = false;
      update();
      await Get.dialog(CustomDialog.showOkMessage(
        context: Get.context!,
        message: _Constant.checkOutAnotherDate,
      ));
      await clearDataLocal();
      homeController.refreshOutlet();
      Get.back();
      return;
    }
    final checkOut = OutletDetailCheckOut(
      coolerId: coolerModel.value.id,
      outletId: outletDetail.value.outletId,
      scanCode: scanQrcodeModel.value.scanCode,
      checkInId:outletDetail.value.checkInId,
      currentStatus: outletDetail.value.currentStatus,
      coolerStatus: ScanStatusEnum.MISSING.name(),
      checkOutText: ScanStatusEnum.MISSING.name() ,
      checkoutStatus:coolerMissing.value?2:(ScanStatusEnum.MISSING.name() !="Success"?3:4),
      outletHotZoneCheck: homeController.configModel.value.outletHotZoneCheck,
      outletStockCountCheck: homeController.configModel.value.outletStockCountCheck,
      questions: coolerMissing.value?[]: hotZoneModel.value.surveys.first.questions.map((question) {
        return QuestionRequest.mapFromQuestion(questionModel: question);
      }).toList(),
    );
    var bodyCheckOut = checkOut.toBodyCheckOut(deviceId: homeController.deviceModel.value.deviceId ?? '', distance: distance);
    final encord = jsonEncode(bodyCheckOut);
    final responseCheckOut = await OutletService.fetchCheckOutOutlet(body: bodyCheckOut);
    update();
    if(responseCheckOut.statusCode == 200) {
      final responseSurvey = OutletCheckOutResponse.fromJsonApi(jsonDecode(responseCheckOut.body));
      // Update outlet
      outletDetail.value.currentStatus = responseSurvey.currentStatus ?? '';
      outletDetail.value.checkOutDate = responseSurvey.checkOutDate;
      outletDetail.value.checkOutTime = responseSurvey.checkOutTime;
      update();
      homeController.outletModel.value.currentStatus = responseSurvey.currentStatus ?? '';
      homeController.outletModel.value.checkOutDate = responseSurvey.checkOutDate;
      homeController.outletModel.value.checkOutTime = responseSurvey.checkOutTime;
      homeController.outletModel.value.checkListData = [responseSurvey];
      if(homeController.outletModel.value.countCheckoutSuccess == 0) {
        homeController.outletModel.value.countCheckoutSuccess = 1;
      }
      homeController.update();
      await updateOutlet();
      await clearDataLocal();
      isPageLoading.value = false;
      update();
      SnackHelper.showMessage(context: Get.context!, message: _Constant.checkOutSuccess);
      Get.back();
    }else {
      isPageLoading.value = false;
      update();
      await Get.dialog(CustomDialog.showOkMessage(
        context: Get.context!,
        message: _Constant.checkOutFail,
      ));
    }
    isPageLoading.value = false;
    update();
  }

  checkOutAnotherDate({required DateTime checkInDate}) async {
    return checkInDate.typeDate().compareTo(DateTime.now().typeDate()) != 0;
  }

  clearDataLocal() async {
    await SqliteDb.deleteRecord(
      tableName: SqliteHelper.tableOutletDetail,
      where: ' outletId = ? ',
      whereArgs: [homeController.outletModel.value.id!,],
    );
    await SqliteDb.deleteRecord(
      tableName: SqliteHelper.tableStock,
      where: ' outletId = ? AND stockCountId = ? ',
      whereArgs: [
        homeController.outletModel.value.id!,
        stockCountModel.value.uuid,
      ],
    );
    await SqliteDb.deleteRecord(
      tableName: SqliteHelper.tableStockCount,
      where: ' outletId = ? ',
      whereArgs: [homeController.outletModel.value.id!,],
    );
    await SqliteDb.deleteRecord(
      tableName: SqliteHelper.tableScan,
      where: ' outletId = ? ',
      whereArgs: [homeController.outletModel.value.id!,],
    );
    await SqliteDb.deleteRecord(
      tableName: SqliteHelper.tableQuestion,
      where: ' outletId = ? AND hotZoneId = ? ',
      whereArgs: [
        homeController.outletModel.value.id!,
        hotZoneModel.value.uuid,
      ],
    );
    await SqliteDb.deleteRecord(
      tableName: SqliteHelper.tableHotZone,
      where: ' outletId = ? ',
      whereArgs: [homeController.outletModel.value.id!,],
    );
    await SqliteDb.deleteRecord(
      tableName: SqliteHelper.tableMaintenance,
      where: ' outletId = ? ',
      whereArgs: [homeController.outletModel.value.id!,],
    );
  }

}
