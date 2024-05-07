import 'dart:io';
import 'dart:typed_data';
import 'package:cooler_mdlz/common/common.dart';
import 'package:cooler_mdlz/controller/home_controller.dart';
import 'package:cooler_mdlz/service/remote_service.dart';
import 'package:image_watermark/image_watermark.dart';
import 'package:path/path.dart' as path;
import 'package:cooler_mdlz/model/entities.dart';
import 'package:cooler_mdlz/view/stock_count/stock_page.dart';
import 'package:flutter/material.dart';

import '../app/utlis/utils.dart';
import '../view/maintenance/maintenance_page.dart';
import 'outlet_detail_controller.dart';
import 'package:image/image.dart' as ui;
class _Constant {
  static const validateQuestion = "Chưa có câu hỏi nào!";
  static const validateDate = "Chưa nhập đủ thông tin!";
}

class HotZoneController extends GetxController {
  final OutletDetailController outletDetailController = Get.find<OutletDetailController>();
  final HomeController homeController = Get.find<HomeController>();
  File? hotZoneFile;
  File? planogramFile;
  var hotZoneModel = HotZoneModel().obs;
  var deletedHotZonePicture = '';
  var deletedPlanogramPicture = '';
  RxBool isPageLoading = true.obs;
  List<TextEditingController> answerEditControllers = [];
  bool isReadOnly = true;
  var hotZonePicture = '';
  Uint8List? watermarkedImgBytes;

  @override
  void onInit() {
    super.onInit();
    hotZonePicture = homeController.configModel.value.hotZonePicture!.replaceAll(
        RegExp('~'), RemoteServices.host);
    if(homeController.outletModel.value.hotZonePicture!=null && homeController.outletModel.value.hotZonePicture!.isNotEmpty)
      {
        hotZonePicture = homeController.outletModel.value.hotZonePicture!.replaceAll(
            RegExp('~'), RemoteServices.host);
      }
    isReadOnly = outletDetailController.selectedOutletDetail == SelectedOutletDetailEnum.VIEW;
  }

  @override
  void dispose() {
    super.dispose();
    if(answerEditControllers.isNotEmpty) {
      for (var controller in answerEditControllers) {
        controller.dispose();
      }
    }
  }

  Future<void> bindingData({required int outletId}) async {
    isPageLoading.value = true;
    update();
    hotZoneModel.value = outletDetailController.hotZoneModel.value;
    await bindingHotZonePicture(outletId: outletId);
    if(hotZoneModel.value.surveys.first.questions.isNotEmpty) {
      for (var question in hotZoneModel.value.surveys.first.questions) {
        question.outletId= homeController.outletModel.value.id;
        answerEditControllers.add(TextEditingController(text: question.answerText ?? ''));
      }
    }
    isPageLoading.value = false;
    update();
  }

  bindingHotZonePicture({required int outletId}) async {
    hotZoneFile = hotZoneModel.value.hotZonePictureLocal!.isEmpty
        ? null : File(hotZoneModel.value.hotZonePictureLocal!);
    planogramFile = hotZoneModel.value.planogramPictureLocal!.isEmpty
        ? null : File(hotZoneModel.value.planogramPictureLocal!);
    if(hotZoneModel.value.hotZonePicture!.isNotEmpty) {
      hotZoneModel.value.hotZonePicture = hotZoneModel.value.hotZonePicture!.replaceAll(
          RegExp('~'), RemoteServices.host);
    }
    if(hotZoneModel.value.planogramPicture!.isNotEmpty) {
      hotZoneModel.value.planogramPicture = hotZoneModel.value.planogramPicture!.replaceAll(
          RegExp('~'), RemoteServices.host);
    }
    update();
  }

  updatePhotoFile({required File file, required bool isHotZone}) async {
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
    String newName = isHotZone ? 'hotzone_$time.jpg' : 'planogram_$time.jpg';
    final newFile = File(file.path).renameSync(path.join(dir,newName));
    newFile.writeAsBytesSync(watermarkedImgBytes!);
    if(isHotZone) {
      hotZoneFile = newFile;
      hotZoneModel.value.hotZonePictureLocal = hotZoneFile?.path ?? '';
    }else {
      planogramFile = newFile;
      hotZoneModel.value.planogramPictureLocal = planogramFile?.path ?? '';
    }
    update();
  }

  deletePhotoFile({required bool isHotZone}) {
    if(isHotZone) {
      deletedHotZonePicture = hotZoneModel.value.hotZonePictureLocal!;
      hotZoneFile = null;
      hotZoneModel.value.hotZonePictureLocal = '';
    }else {
      deletedPlanogramPicture = hotZoneModel.value.planogramPictureLocal!;
      planogramFile = null;
      hotZoneModel.value.planogramPictureLocal = '';
    }
    update();
  }

  checkAnswerType1({required int index, required int result,}) {
    if(isReadOnly) return;
    hotZoneModel.value.surveys.first.questions[index].isAnswer1Input = result == 1;
    hotZoneModel.value.surveys.first.questions[index].isAnswer2Input = result == 2;
    hotZoneModel.value.surveys.first.questions[index].isAnswer3Input = result == 3;
    hotZoneModel.value.surveys.first.questions[index].isAnswer4Input = result == 4;
    update();
  }

  checkAnswerType2({required int index, required int result}) {
    if(isReadOnly) return;
    switch (result) {
      case 1:
        hotZoneModel.value.surveys.first.questions[index].isAnswer1Input = !(hotZoneModel.value.surveys.first.questions[index].isAnswer1Input ?? false);
        break;
      case 2:
        hotZoneModel.value.surveys.first.questions[index].isAnswer2Input = !(hotZoneModel.value.surveys.first.questions[index].isAnswer2Input ?? false);
        break;
      case 3:
        hotZoneModel.value.surveys.first.questions[index].isAnswer3Input = !(hotZoneModel.value.surveys.first.questions[index].isAnswer3Input ?? false);
        break;
      case 4:
        hotZoneModel.value.surveys.first.questions[index].isAnswer4Input = !(hotZoneModel.value.surveys.first.questions[index].isAnswer4Input ?? false);
        break;
    }
    update();
  }

  saveStep({required bool isUpdate}) async {
    for (var question in hotZoneModel.value.surveys.first.questions) {
      question.outletId= homeController.outletModel.value.id;
      answerEditControllers.add(TextEditingController(text: question.answerText ?? ''));
    }
    for(int i = 0; i < hotZoneModel.value.surveys.first.questions.length; i++) {
      hotZoneModel.value.surveys.first.questions[i].answerText = answerEditControllers[i].text;
    }
    if(homeController.configModel.value.outletHotZoneCheck == 1) {
      if(hotZoneModel.value.surveys.first.questions.isEmpty) {
        await Get.dialog(CustomDialog.showOkMessage(
          context: Get.context!,
          message: _Constant.validateQuestion,
        ));
        return;
      }
      if(!validateData()) {
        await Get.dialog(CustomDialog.showOkMessage(
          context: Get.context!,
          message: _Constant.validateDate,
        ));
        return;
      }
    }
    isPageLoading.value = true;
    update();
    final completedTime = DateTime.now();
    if(hotZoneModel.value.surveys.first.questions.isNotEmpty) {
      for (int i = 0; i < hotZoneModel.value.surveys.first.questions.length; i++) {
        hotZoneModel.value.surveys.first.questions[i].answerText = answerEditControllers[i].text;
        hotZoneModel.value.surveys.first.questions[i].answerInput1 = answerEditControllers[i].text;
      }
    }
    hotZoneModel.value.completedTime = completedTime;
    hotZoneModel.value.visitDate = completedTime.typeDate();
    update();
    if(isUpdate) {
      await SqliteDb.updateRecord(
        tableName: SqliteHelper.tableHotZone,
        maps: hotZoneModel.value.toMap(),
        where: ' outletId = ? AND uuid = ? ',
        whereArgs: [hotZoneModel.value.outletId, hotZoneModel.value.uuid],
      );
      for (int i = 0; i < hotZoneModel.value.surveys.first.questions.length; i++) {
        await SqliteDb.updateRecord(
          tableName: SqliteHelper.tableQuestion,
          maps: hotZoneModel.value.surveys.first.questions[i].toMap(),
          where: ' outletId = ? AND hotZoneId = ? AND questionId = ? ',
          whereArgs: [
            hotZoneModel.value.outletId,
            hotZoneModel.value.surveys.first.questions[i].hotZoneId,
            hotZoneModel.value.surveys.first.questions[i].questionId
          ],
        );
      }
    }else {
      await SqliteDb.insertRecord(
        tableName: SqliteHelper.tableHotZone,
        maps: hotZoneModel.value.toMap(),
      );
      for (int i = 0; i < hotZoneModel.value.surveys.first.questions.length; i++) {
        hotZoneModel.value.surveys.first.questions[i].outletId = hotZoneModel.value.outletId;
        hotZoneModel.value.surveys.first.questions[i].hotZoneId = hotZoneModel.value.uuid;
        update();
        await SqliteDb.insertRecord(
          tableName: SqliteHelper.tableQuestion,
          maps: hotZoneModel.value.surveys.first.questions[i].toMap(),
        );
      }
    }
    if(deletedHotZonePicture.isNotEmpty) {
      Directory(deletedHotZonePicture).delete(recursive: true).then((_) {
        printInfo(info: 'Deleted $deletedHotZonePicture');
      });
    }
    if(deletedPlanogramPicture.isNotEmpty) {
      Directory(deletedPlanogramPicture).delete(recursive: true).then((_) {
        printInfo(info: 'Deleted $deletedPlanogramPicture');
      });
    }
    outletDetailController.hotZoneModel = hotZoneModel;
    outletDetailController.steps[1].status = 1;
    outletDetailController.steps[1].visitDate = completedTime.typeDate();
    outletDetailController.showCheckOutOutlet();
    outletDetailController.update();
    isPageLoading.value = false;
    update();
    Get.offNamed(MaintenancePage.route);
  }

  bool validateData() {
    if(hotZoneModel.value.hotZonePictureLocal?.isEmpty ?? true) return false;
    if(hotZoneModel.value.planogramPictureLocal?.isEmpty ?? true) return false;
    for (var question in hotZoneModel.value.surveys.first.questions) {
      if(!question.isAnswer1Input! && !question.isAnswer2Input! && !question.isAnswer3Input! && !question.isAnswer4Input!
          && question.answerType == 1) {
        return false;
      }
      if(!question.isAnswer1Input! && !question.isAnswer2Input! && !question.isAnswer3Input! && !question.isAnswer4Input!
          && question.answerType == 2) {
        return false;
      }
      if(question.answerText == '' && question.answerType == 3) {
        return false;
      }
    }
    return true;
  }

}
