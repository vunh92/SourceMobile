import 'dart:async';

import 'package:cooler_mdlz/common/common.dart';
import 'package:cooler_mdlz/view/google_map_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import '../app/utlis/utils.dart';
import '../model/entities.dart';
import '../model/mock_data.dart';
import '../service/connection/connection_status_singleton.dart';
import '../view/home/home_page.dart';
import '../view/outlet/outlet_detail_page.dart';
import '../service/remote_service.dart';
import '../view/outlet/outlet_detail_view_page.dart';
import '../view/splash/welcome_page.dart';

class HomeController extends GetxController {
  RxBool isPageLoading = true.obs;
  var configModel = ConfigModel().obs;
  var deviceModel = DeviceModel().obs;
  var userModel = UserModel().obs;
  var salesModel = SaleModel().obs;
  var allOutlets = <OutletModel>[].obs;
  var todayOutlets = <OutletModel>[].obs;
  var checkedOutlets = <OutletModel>[].obs;
  var unCheckedOutlets = <OutletModel>[].obs;
  var outletModel = OutletModel().obs;
  var locationModel = LocationModel().obs;
  var searchEditController = TextEditingController();
  var myFocusNode = FocusNode();
 // var deviceIDGet ="".obs;
 // var IMEIGet = "".obs;
  var searchAllOutlets = <OutletModel>[].obs;
  var searchOutletVisits = <OutletModel>[].obs;
  var searchUncheckedOutlets = <OutletModel>[].obs;
  var searchCheckedOutlets = <OutletModel>[].obs;
  var selectedDate = DateTime.now().obs;
  var allCoolers = <CoolerModel>[].obs;
  var allSurvey = <SurveyModel>[].obs;
  var selectedTab = 1.obs;
  bool isOnline = true;
  late ConnectionStatusSingleton connectionStatusSingleton;
  late Timer timer;

  @override
  void onInit() {
    super.onInit();
    try{
      String? appTime = SharedPreferencesUtil.getInstance.get<String>(SharedPreFerencesKey.appTime) ?? '';
      if(appTime != DateTime.now().typeDate().toString()) {
        SqliteDb.clearAllTable();
        clearCacheDir();
        SharedPreferencesUtil.getInstance.putData(
          SharedPreFerencesKey.appTime,
          DateTime.now().typeDate().toString(),
        );
      }
      myFocusNode.unfocus();
      connectionStatusSingleton = ConnectionStatusSingleton.getInstance();
      connectionStatusSingleton.checkConnection();
      connectionStatusSingleton.connectionChange.listen((event) {
        isOnline = event;
      });
      timer = Timer.periodic(const Duration(seconds: timeRealtimeData), (Timer t) async {
        try{
          printInfo(info: 'Timer.periodic(Duration(seconds: $timeRealtimeData)');
          printInfo(info: Get.currentRoute);
          if(Get.currentRoute == HomePage.route || Get.currentRoute == WelcomeScreen.route) {
            var resConfig = await HomeService.fetchConfig(deviceModel.value.deviceId!);
            var ok=false;
            if (resConfig.statusCode == 200) {
              ok=true;
              configModel.value = ConfigModel.fromJsonApi(jsonDecode(resConfig.body));
              configModel.value.location = locationModel.value;
              if (configModel.value.device != null) {
                deviceModel.value = configModel.value.device!;
              }
              salesModel.value = SaleModel.fromJsonApi(jsonDecode(resConfig.body)['Device']['Sale']);
              salesModel.value.id = deviceModel.value.saleId ?? 0;
              update();
              if(deviceModel.value.deviceStatus == 0) {
                var result = await showDialog(
                  barrierDismissible: false,
                  context: Get.context!,
                  builder: (context) {
                    return const NoInternetDialog(error: ErrorConnectedEnum.DEVICE,);
                  },
                );
                SystemNavigator.pop();
                return;
              }
              if(salesModel.value.salesPersonCode==null|| salesModel.value.salesPersonCode=="")
              {
                var result = await showDialog(
                  barrierDismissible: false,
                  context: Get.context!,
                  builder: (context) {
                    return const NoInternetDialog(error: ErrorConnectedEnum.DEVICE,);
                  },
                );
                SystemNavigator.pop();
                return;
              }
            }

            if(selectedDate == null || deviceModel.value.deviceId!.isEmpty
                || selectedDate.value.typeDate().compareTo(DateTime.now().typeDate()) != 0) return;
            if(ok){
              final allOutlet = await getAllOutlet(deviceId: deviceModel.value.deviceId);
              final allOutletVisit = await getAllOutletVisit(deviceId: deviceModel.value.deviceId);
              final todayOutlet = await getOutletVisit(deviceId: deviceModel.value.deviceId);
              //if(allOutlet.isNotEmpty)
              //if(allOutlet.isNotEmpty)
                  {
                sortList(allOutlet);
                allOutlets.value = allOutlet;

              }
              checkedOutlets.value = allOutletVisit;
              // if(todayOutlet.isNotEmpty)
                  {
                sortList(todayOutlet);
                todayOutlets.value = todayOutlet;
                unCheckedOutlets.value = getUnCheckedList(list: todayOutlet);
              }
              searchOutletOnTab();
              update();
            }


          }
        }catch(e){

        }

      });
    }catch(e)
    {

    }

  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  refreshOutlet() async {
     final allOutlet = await getAllOutlet(deviceId: deviceModel.value.deviceId, date: selectedDate.value.toStringWithFormat(format: 'yyyy-MM-dd'));
     final allOutletVisit = await getAllOutletVisit(deviceId: deviceModel.value.deviceId);
     final todayOutlet = await getOutletVisit(deviceId: deviceModel.value.deviceId);
     if(allOutlet.isNotEmpty) {
       sortList(allOutlet);
       allOutlets.value = allOutlet;
     }
     checkedOutlets.value =allOutletVisit;
     if(todayOutlet.isNotEmpty) {
       sortList(todayOutlet);
       todayOutlets.value = todayOutlet;
       unCheckedOutlets.value = getUnCheckedList(list: todayOutlet);
     }
     searchOutletOnTab();
     update();
  }

  refreshOutletWithID({required int id}) async {

    for(var item in allOutlets)
      {
        if (item.id==id){
          await bindingScan(outlet: item);
          break;
        }
      }
    for(var item in checkedOutlets)
    {
      if (item.id==id){
        await bindingScan(outlet: item);
        break;
      }
    }
    for(var item in todayOutlets)
    {
      if (item.id==id){
        await bindingScan(outlet: item);
        break;
      }
    }
    for(var item in unCheckedOutlets)
    {
      if (item.id==id){
        await bindingScan(outlet: item);
        break;
      }
    }

    update();
  }

  searchOutletOnTab() {
    switch (selectedTab.value) {
      case 0:
        searchAllOutlets.clear();
        allOutlets.where((p0) => p0.nameNormalize!.toLowerCase().contains(searchEditController.text.trim().toLowerCase()) ||
            p0.name!.toLowerCase().contains(searchEditController.text.trim().toLowerCase())).forEach((element) {
          searchAllOutlets.add(element);
        });
        sortList(searchAllOutlets);
        break;
      case 1:
        searchOutletVisits.clear();
        todayOutlets.where((p0) => p0.nameNormalize!.toLowerCase().contains(searchEditController.text.trim().toLowerCase()) ||
            p0.name!.toLowerCase().contains(searchEditController.text.trim().toLowerCase())).forEach((element) {
          searchOutletVisits.add(element);
        });
        sortList(searchOutletVisits);
        break;
      case 2:
        searchUncheckedOutlets.clear();
        unCheckedOutlets.where((p0) => p0.nameNormalize!.toLowerCase().contains(searchEditController.text.trim().toLowerCase()) ||
            p0.name!.toLowerCase().contains(searchEditController.text.trim().toLowerCase())).forEach((element) {
          searchUncheckedOutlets.add(element);
        });
        sortList(searchUncheckedOutlets);
        break;
      case 3:
        searchCheckedOutlets.clear();
        checkedOutlets.where((p0) => p0.nameNormalize!.toLowerCase().contains(searchEditController.text.trim().toLowerCase()) ||
            p0.name!.toLowerCase().contains(searchEditController.text.trim().toLowerCase())).forEach((element) {
          searchCheckedOutlets.add(element);
        });
        sortList(searchCheckedOutlets);
        break;
    }
    update();
  }

  clearSearchOutlet() {
    searchEditController.clear();
    searchAllOutlets.clear();
    searchOutletVisits.clear();
    searchUncheckedOutlets.clear();
    searchCheckedOutlets.clear();
    myFocusNode.unfocus();
    update();
  }

  set setLocation(Position position) {
    locationModel.value = LocationModel(lat: position.latitude, long: position.longitude);
    update();
  }

  selectTab(int index) {
    selectedTab.value = index;
    clearSearchOutlet();
    update();
  }

  selectDate(DateTime date) async {
    if(selectedDate.value.typeDate() == date.typeDate()) return;
    if (!isOnline) {
      await showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {
          return const NoInternetDialog(error: ErrorConnectedEnum.WIFI,);
        },
      );
      return;
    }
    isPageLoading.value = true;
    update();
    selectedDate.value = date;
    allOutlets.value = await getAllOutlet(deviceId: deviceModel.value.deviceId, date: date.toStringWithFormat(format: 'yyyy-MM-dd'));

    sortList(allOutlets.value);
    clearSearchOutlet();
    isPageLoading.value = false;
    update();
  }

  selectOutlet({required OutletModel outlet}) {
    outletModel.value = outlet;
    myFocusNode.unfocus();
    update();
    Get.toNamed(OutletDetailPage.route, arguments: SelectedOutletDetailEnum.REVISIT);
  }

  viewOutletDetail({required OutletModel outlet}) async {
    outletModel.value = outlet;
    int result = await Get.dialog(const ViewOutletDetailDialog());
    if(result == 1)  Get.toNamed(OutletDetailViewPage.route, arguments: SelectedOutletDetailEnum.VIEW);
    if(result == 2)  Get.toNamed(OutletDetailPage.route, arguments: SelectedOutletDetailEnum.REVISIT);
  }

  Future<void> openMap({required OutletModel outletModel}) async {
    Get.toNamed(GoogleMapPage.route, arguments: outletModel);
  }

  setInfoDevice({required DeviceModel deviceModel }) async {
   // this.deviceIDGet=deviceModel.deviceId as RxString;
  //  this.IMEIGet=deviceModel.imei as RxString;
    this.deviceModel.value = deviceModel;
    update();
  }

  Future<void> checkDeviceFromApi({deviceId = ''}) async {
    if (isOnline) {
      isPageLoading.value = true;
      update();
      var resDevice = await HomeService.fetchAddDeviceInfo(deviceModel: deviceModel.value);
      var resConfig = await HomeService.fetchConfig(deviceId);
      if (resConfig.statusCode == 200) {
        final configResponse = ConfigResponse.fromJsonApi(jsonDecode(resConfig.body));
        configModel.value = configResponse.mapConfigModel();
        configModel.value.location = locationModel.value;
        if (configModel.value.device != null) {
          deviceModel.value = configModel.value.device!;
          update();
        }
        if(deviceModel.value.deviceStatus == 0) {
          var result = await showDialog(
            barrierDismissible: false,
            context: Get.context!,
            builder: (context) {
              return const NoInternetDialog(error: ErrorConnectedEnum.DEVICE,);
            },
          );
          SystemNavigator.pop();
          return;
        }
        salesModel.value = deviceModel.value.sale!;
        salesModel.value.id = deviceModel.value.saleId ?? 0;
        if(salesModel.value.salesPersonCode==null|| salesModel.value.salesPersonCode=="")
          {
            var result = await showDialog(
              barrierDismissible: false,
              context: Get.context!,
              builder: (context) {
                return const NoInternetDialog(error: ErrorConnectedEnum.DEVICE,);
              },
            );
            SystemNavigator.pop();
            return;
          }
        allOutlets.value = await getAllOutlet(deviceId: deviceId);
        var allOutletsVisit= await getAllOutletVisit(deviceId: deviceId);
        todayOutlets.value = await getOutletVisit(deviceId: deviceId);
        sortList(allOutlets);
        sortList(todayOutlets);
        checkedOutlets.value =allOutletsVisit;
        unCheckedOutlets.value = getUnCheckedList(list: todayOutlets);
        isPageLoading.value = false;
        update();
        if(!deviceModel.isNull){
          Get.offAllNamed(HomePage.route);
        }
      } else {
        isPageLoading.value = false;
        update();
        if(resConfig.statusCode == 408) {
          var result = await showDialog(
            barrierDismissible: false,
            context: Get.context!,
            builder: (context) {
              return const NoInternetDialog(error: ErrorConnectedEnum.WIFI,);
            },
          );
          if(result) SystemNavigator.pop();
        }
        var result = await showDialog(
          barrierDismissible: false,
          context: Get.context!,
          builder: (context) {
            return const NoInternetDialog(error: ErrorConnectedEnum.DEVICE,);
          },
        );
        if(result) SystemNavigator.pop();
      }
    }else {
      var result = await showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {
          return const NoInternetDialog(error: ErrorConnectedEnum.WIFI,);
        },
      );
      if(result) SystemNavigator.pop();
    }
  }
  bindingScan({required OutletModel outlet,}) async {
    final scans = await SqliteDb.getRecords(
      tableName: SqliteHelper.tableScan,
      where: ' outletId = ?',
      whereArgs: [outlet.id],
      limit: 1,
    );
    if (scans.isNotEmpty) {
      var scanModel = ScanQrcodeModel.generateNoColler(scans.first);
      var cStatus="";
        if(scanModel.assetStatus==1){
          cStatus=ScanStatusEnum.DAMAGE.name();
        }
        else if(scanModel.assetStatus==2){
          cStatus=ScanStatusEnum.MISSING.name();
        }
        else if(scanModel.assetStatus==3){
          cStatus=ScanStatusEnum.FAIL.name();
        }
        if(cStatus!=""){
          outlet.coolerStatus=cStatus;
        }

    }
  }
  Future<List<OutletModel>> getAllOutlet({deviceId = '', date = ''}) async {
    var res = await HomeService.fetchAllOutlet(deviceId: deviceId, date: date);
    if (res.statusCode == 200) {
      final dataResponse = jsonDecode(res.body) as List;
      final allOutlets = dataResponse.map((e) => OutletModel.fromJsonApi(e)).toList().map((e) {
        //bindingScan(outlet: e, visitDate: DateTime.now());
        e.distance = Utils.getDistance(
          latStart: locationModel.value.lat ?? 0,
          longStart: locationModel.value.long ?? 0,
          latEnd: e.lat ?? 0,
          longEnd: e.long ?? 0,
        );
        return e;
      }).toList();
      for(var item in allOutlets)
        {
          await  bindingScan(outlet: item);
        }
      return allOutlets;
    } else {
      return [];
    }
  }
  Future<List<OutletModel>> getAllOutletVisit({deviceId = '', date = ''}) async {
    var res = await HomeService.fetchAllOutletVisit(deviceId: deviceId, date: date);
    if (res.statusCode == 200) {
      final dataResponse = jsonDecode(res.body) as List;
      final allOutlets = dataResponse.map((e) => OutletModel.fromJsonApi(e)).toList().map((e) {


        //bindingScan(outlet: e, visitDate: DateTime.now());
        e.distance = Utils.getDistance(
          latStart: locationModel.value.lat ?? 0,
          longStart: locationModel.value.long ?? 0,
          latEnd: e.lat ?? 0,
          longEnd: e.long ?? 0,
        );
        return e;
      }).toList();
      for(var item in allOutlets)
      {
        await  bindingScan(outlet: item);
      }
      return allOutlets;
    } else {
      return [];
    }
  }
  Future<List<OutletModel>> getOutletVisit({deviceId = '', date = ''}) async {
    var res = await HomeService.fetchOutletVisit(deviceId: deviceId, date: date);
    if (res.statusCode == 200) {
      final dataResponse = jsonDecode(res.body) as List;
      final allOutlets = dataResponse.map((e) => OutletModel.fromJsonApi(e)).toList().map((e) {

        e.distance = Utils.getDistance(
          latStart: locationModel.value.lat ?? 0,
          longStart: locationModel.value.long ?? 0,
          latEnd: e.lat ?? 0,
          longEnd: e.long ?? 0,
        );
        return e;
      }).toList();
      for(var item in allOutlets)
      {
        await  bindingScan(outlet: item);
      }
      return allOutlets;
    } else {
      return [];
    }
  }

  Future<List<OutletModel>> getCheckedList() async {
    return await getAllOutletVisit(deviceId: deviceModel.value.deviceId);
  }

  List<OutletModel> getUnCheckedList({required List<OutletModel> list}) {
    final newList = <OutletModel>[];
    if(list.isEmpty) return [];
    list.forEach((element) {
      if(element.checkOutDate == null) {
        newList.add(element);
      }
    });
    return newList;
  }

  sortList(List<OutletModel> list) {
    list.sort((a, b) => a.distance!.compareTo(b.distance!));
  }

  clearCacheDir() async {
    final cacheDir = await getTemporaryDirectory();
    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }
}
