import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/utlis/utils.dart';
import '../../common/common.dart';
import '../../controller/maintenance_controller.dart';
import '../../controller/outlet_detail_controller.dart';
import '../../model/entities.dart';

class _Constant {
  static const minHeadline = 10;
  static const maxHeadline = 10;
  static const sizePicture = 100.0;
  static const sizeProductImage = 50.0;
  static const stepPage = '3/3 steps';
  static const attachPicture = 'Đính kèm hình ảnh vấn đề cần được bảo trì';
  static const addPhoto = 'Add photo';
  static const detailDescription = 'Mô tả chi tiết';
  static const hintDetailDescription = "Tủ đang gặp vấn đề gì? Mô tả chi tiết trạng thái bảo trì của thiết bị.";
  static const deletePhotoMessage = "Bạn muốn xóa hình này?";
}

class MaintenancePage extends StatefulWidget {
  static const route = '/maintenance';

  const MaintenancePage({Key? key}) : super(key: key);

  @override
  State<MaintenancePage> createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  late OwnThemeFields themeOwn;
  final OutletDetailController outletDetailController = Get.find<OutletDetailController>();
  final MaintenanceController maintenanceController = Get.find<MaintenanceController>();

  @override
  void initState() {
    super.initState();
    maintenanceController.bindingData(outletId: outletDetailController.outletDetail.value.outletId!);
  }

  Future<File?> _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: NumberConstant.widthDevice(context)*3,
      maxHeight: NumberConstant.heightDevice(context)*3,
      imageQuality: 100
    );
    if (pickedFile == null) return null;
    return File(pickedFile.path);
  }

  @override
  Widget build(BuildContext context) {
    themeOwn = Theme.of(context).own();
    return Scaffold(
      appBar: _appBar(),
      body: GetBuilder<MaintenanceController>(
          init: maintenanceController,
          builder: (controller) {
            return _buildBody(context);
          }
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppString.maintenance,
            style: AppTextStyle.textStyleAppBar,
          ),
          Text(_Constant.stepPage,
            style: AppTextStyle.textStyleAppBar.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
      titleSpacing: 0,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _attachPictureWidget(context),
                    Padding(
                      padding: const EdgeInsets.all(NumberConstant.basePaddingLarge),
                      child: _detailWidget(context),
                    ),
                    const SizedBox(height: NumberConstant.marginInfo,),
                  ],
                ),
              ),
            ),
            if(outletDetailController.selectedOutletDetail != SelectedOutletDetailEnum.VIEW)
              _bottomButton(context),
          ],
        ),
        if(maintenanceController.isPageLoading.value)
          Container(
            color: themeOwn.dividerColor.withOpacity(0.5),
            child: Center(child: CircularProgressIndicator(
              color: themeOwn.mainColor,
            )),
          )
      ],
    );
  }

  Widget _attachPictureWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(NumberConstant.basePaddingLarge),
          child: Text(_Constant.attachPicture,
            style: themeOwn.textStyleDetailTitle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: NumberConstant.basePaddingMedium,
          ),
          child: SizedBox(
            height: _Constant.sizePicture + NumberConstant.basePaddingLarge,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: maintenanceController.maintenanceFiles.length + 1,
              itemBuilder: (context, index) {
                return _maintenanceItem(context, index);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _maintenanceItem(BuildContext context, int index) {
    if(index == maintenanceController.maintenanceFiles.length) return _emptyItem(index);
    File? maintenanceFile = maintenanceController.maintenanceFiles[index];
    return maintenanceController.maintenanceModel.value.maintenancePicture1!.isNotEmpty
        ? Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(NumberConstant.basePaddingMedium),
          child: SizedBox(
            height: _Constant.sizePicture,
            width: _Constant.sizePicture,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
              child: Container(
                color: Colors.black,
                child: CachedNetworkImage(
                  placeholder: (context, url) => Container(
                    height: _Constant.sizePicture,
                    width: _Constant.sizePicture,
                    color: themeOwn.dividerColor,
                    child: Center(
                      child: CircularProgressIndicator(color: themeOwn.mainColor,),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    decoration: BoxDecoration(
                      color: AppColor.appColorLight2,
                      borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
                      border: Border.all(
                        width: 1,
                        color: themeOwn.dividerColor,
                      ),
                    ),
                    child: Center(
                      child: SizedBox(
                        height: _Constant.sizeProductImage,
                        width: _Constant.sizeProductImage,
                        child: SvgPicture.asset(
                          width: NumberConstant.basePaddingLarge,
                          assetIconsPath + iconImageSvg,
                          color: themeOwn.dividerColor,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  imageUrl: maintenanceController.maintenanceModel.value.maintenancePicture1!,
                  fit: BoxFit.contain,
                  height: _Constant.sizePicture,
                  width: double.infinity,
                ),
              ),
            ),
          ),
        ),
      ],
    )
        : maintenanceFile == null
        ? Container()
        : Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(NumberConstant.basePaddingMedium),
          child: SizedBox(
            height: _Constant.sizePicture,
            width: _Constant.sizePicture,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
              child: Container(
                color: Colors.black,
                child: Image.file(
                  maintenanceFile,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () async {
              final result = await Get.dialog(CustomDialog.showOkCancelAlertDialog(
                context: context,
                message: _Constant.deletePhotoMessage,
              ));
              if(!result) return;
              maintenanceController.deleteMaintenanceFile(index: index);
            },
            child: SvgPicture.asset(
              assetIconsPath + iconCloseSvg,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  Widget _emptyItem(int index) {
    if(maintenanceController.isReadOnly) return Container();
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () async {
        if(maintenanceController.isReadOnly) return;
        final result = await _getFromCamera();
        if(result == null) return;
        await maintenanceController.updateMaintenanceFile(file: result, index: index);
      },
      child: Padding(
        padding: const EdgeInsets.all(NumberConstant.basePaddingMedium),
        child: Container(
          color: themeOwn.backgroundColor,
          height: _Constant.sizePicture,
          width: _Constant.sizePicture,
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(NumberConstant.baseRadiusBorderSmall),
            padding: const EdgeInsets.all(NumberConstant.basePaddingLarge),
            dashPattern: const <double>[8, 4],
            color: AppColor.appColorDark4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  assetIconsPath + iconPhotoSvg,
                  color: themeOwn.mainColor,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: NumberConstant.basePaddingSmall),
                  child: Text(_Constant.addPhoto,
                    style: themeOwn.textStyleListDetail,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailWidget(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: NumberConstant.basePaddingMedium,
          ),
          child: Text(_Constant.detailDescription,
            style: themeOwn.textStyleHeaderDefault,
          ),
        ),
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: themeOwn.backgroundColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(NumberConstant.baseRadiusBorderMedium),
              ),
              borderSide: BorderSide(color: themeOwn.backgroundColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(NumberConstant.baseRadiusBorderMedium),
              ),
              borderSide: BorderSide(color: themeOwn.backgroundColor),
            ),
            hintText: _Constant.hintDetailDescription,
            hintStyle: themeOwn.textStyleHint,
            contentPadding: const EdgeInsets.all(NumberConstant.basePaddingLarge),
          ),
          minLines: _Constant.minHeadline,
          maxLines: _Constant.maxHeadline,
          // maxLength: _Constant.maxCharacter,
          controller: maintenanceController.detailEditController,
          style: themeOwn.textStyleDefault,
          enabled: !maintenanceController.isReadOnly,
        )
      ],
    );
  }

  Widget _bottomButton(BuildContext context) {
    return RawMaterialButton(
      fillColor: AppColor.mainColor,
      onPressed: () async {
        await maintenanceController.saveStep(
          isUpdate: outletDetailController.steps[2].status == 1,
        );
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(NumberConstant.basePaddingLarge),
          child: Text(AppString.doneUppercase,
            style: themeOwn.textStyleMainButton!.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
