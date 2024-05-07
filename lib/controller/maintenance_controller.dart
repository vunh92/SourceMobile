import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cooler_mdlz/common/common.dart';
import 'package:cooler_mdlz/model/entities.dart';
import 'package:cooler_mdlz/model/mock_data.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import '../app/utlis/utils.dart';
import '../service/remote_service.dart';
import 'outlet_detail_controller.dart';
import 'package:image_watermark/image_watermark.dart';
import 'package:image/image.dart' as ui;
class MaintenanceController extends GetxController {
  final OutletDetailController outletDetailController = Get.find<OutletDetailController>();
  List<File?> maintenanceFiles = [];
  List<String> deletedPictures = [];
  var maintenanceModel = MaintenanceModel().obs;
  RxBool isPageLoading = true.obs;
  final detailEditController = TextEditingController();
  bool isReadOnly = true;

  @override
  void onInit() {
    super.onInit();
    isReadOnly = outletDetailController.selectedOutletDetail == SelectedOutletDetailEnum.VIEW;
  }

  @override
  void dispose() {
    super.dispose();
    detailEditController.dispose();
  }

  Future<void> bindingData({required int outletId}) async {
    isPageLoading.value = true;
    update();
    maintenanceModel = outletDetailController.maintenanceModel;
    detailEditController.text = maintenanceModel.value.description ?? '';
    if(maintenanceModel.value.maintenancePicture1?.isNotEmpty ?? false) {
      maintenanceModel.value.maintenancePicture1 = maintenanceModel.value.maintenancePicture1!.replaceAll(
          RegExp('~'), RemoteServices.host);
      maintenanceFiles.add(File(maintenanceModel.value.maintenancePicture1!));
    }else if(maintenanceModel.value.maintenancePicture1Local?.isNotEmpty ?? false) {
      maintenanceFiles.add(File(maintenanceModel.value.maintenancePicture1Local!));
    }

    if(maintenanceModel.value.maintenancePicture2?.isNotEmpty ?? false) {
      maintenanceModel.value.maintenancePicture2 = maintenanceModel.value.maintenancePicture2!.replaceAll(
          RegExp('~'), RemoteServices.host);
      maintenanceFiles.add(File(maintenanceModel.value.maintenancePicture2!));
    }else if(maintenanceModel.value.maintenancePicture2Local?.isNotEmpty ?? false) {
      maintenanceFiles.add(File(maintenanceModel.value.maintenancePicture2Local!));
    }

    if(maintenanceModel.value.maintenancePicture3?.isNotEmpty ?? false) {
      maintenanceModel.value.maintenancePicture3 = maintenanceModel.value.maintenancePicture3!.replaceAll(
          RegExp('~'), RemoteServices.host);
      maintenanceFiles.add(File(maintenanceModel.value.maintenancePicture3!));
    }else if(maintenanceModel.value.maintenancePicture3Local?.isNotEmpty ?? false) {
      maintenanceFiles.add(File(maintenanceModel.value.maintenancePicture3Local!));
    }
    isPageLoading.value = false;
    update();
  }
  Uint8List? watermarkedImgBytes;
  updateMaintenanceFile({required File file, required int index}) async {
    var decodedImage = await decodeImageFromList(file.readAsBytesSync());
    var fileImage = await file.readAsBytes();
    Uint8List? imgBytes = Uint8List.fromList(fileImage);
    watermarkedImgBytes = await ImageWatermark.addTextWatermark(
        imgBytes: imgBytes,
        watermarkText: DateTime.now().toStringWithFormat(format: DateTimeConstant.dateTimeFormat).toString(),
        color:  Colors.tealAccent,
        dstX: 20,
        dstY: decodedImage.height - 50,
        font:ui.arial_24
    );
    String dir = path.dirname(file.path);
    String time = DateTime.now().microsecondsSinceEpoch.toString();
    String newName = 'maintenance_$time.jpg';
    final newFile = File(file.path).renameSync(path.join(dir,newName));
    newFile.writeAsBytesSync(watermarkedImgBytes!);

    maintenanceFiles.add(newFile);


    switch (index) {
      case 0:
        maintenanceModel.value.maintenancePicture1Local = newFile.path;
        break;
      case 1:
        maintenanceModel.value.maintenancePicture2Local = newFile.path;
        break;
      case 2:
        maintenanceModel.value.maintenancePicture3Local = newFile.path;
        break;
    }
    update();
  }

  deleteMaintenanceFile({required int index}) {
    maintenanceFiles.removeAt(index);
    switch (index) {
      case 0:
        deletedPictures.add(maintenanceModel.value.maintenancePicture1Local!);
        maintenanceModel.value.maintenancePicture1Local = "";
        break;
      case 1:
        deletedPictures.add(maintenanceModel.value.maintenancePicture2Local!);
        maintenanceModel.value.maintenancePicture2Local = "";
        break;
      case 2:
        deletedPictures.add(maintenanceModel.value.maintenancePicture3Local!);
        maintenanceModel.value.maintenancePicture3Local = "";
        break;
    }
    update();
  }

  saveStep({required bool isUpdate}) async {
    isPageLoading.value = true;
    maintenanceModel.value.description = detailEditController.text;
    final completedTime = DateTime.now();
    maintenanceModel.value.completedTime = completedTime;
    maintenanceModel.value.visitDate = completedTime.typeDate();
    update();
    if(isUpdate) {
      await SqliteDb.updateRecord(
        tableName: SqliteHelper.tableMaintenance,
        maps: maintenanceModel.value.toMap(),
        where: ' outletId = ? AND uuid = ? ',
        whereArgs: [maintenanceModel.value.outletId, maintenanceModel.value.uuid],
      );
    }else {
      await SqliteDb.insertRecord(
        tableName: SqliteHelper.tableMaintenance,
        maps: maintenanceModel.value.toMap(),
      );
    }
    if(deletedPictures.isNotEmpty) {
      for(var picture in deletedPictures) {
        Directory(picture).delete(recursive: true).then((_) {
          printInfo(info: 'Deleted $picture');
        });
      }
    }
    outletDetailController.maintenanceModel  = maintenanceModel;
    outletDetailController.steps[2].status = 1;
    outletDetailController.steps[2].visitDate = completedTime.typeDate();
    outletDetailController.showCheckOutOutlet();
    outletDetailController.update();
    isPageLoading.value = false;
    update();
    Get.back();
  }
}
