import 'package:cooler_mdlz/view/qrcode/qrcode_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/utlis/utils.dart';
import '../../common/common.dart';
import '../../controller/home_controller.dart';
import '../../controller/outlet_detail_controller.dart';
import '../../controller/scan_qrcode_controller.dart';
import '../../model/entities.dart';
import 'scan_qrcode_screen.dart';

class _Constant {
  static const sizeIconAppbar = 14.0;
  static const sizeIconOutletInfo = 36.0;
  static const stepPage = '1/3 steps';
  static const coolerSerialCode = 'Mã serial tủ';
  static const coolerStatus = 'Trạng thái tủ';
  static const note = 'Ghi chú';
  static const hintNote = 'Nhập ghi chú';
  static const minHeadline = 7;
  static const maxHeadline = 10;
  static const asset = 'Thông tin tài sản';
  static const assetCode = 'Mã tài sản';
  static const assetStatus = 'Trạng thái tài sản';
  static const matching = 'Trùng khớp';
  static const notMatching = 'Không trùng khớp';
  static const outletInformation = 'Thông tin cửa hàng';
  static const outletName = 'Tên cửa hàng';
  static const location = 'Địa chỉ';
  static const phone = 'Điện thoại';
}

class ScanQrcodePage extends StatefulWidget {
  static const route = '/scan_qrcode';

  const ScanQrcodePage({Key? key}) : super(key: key);

  @override
  State<ScanQrcodePage> createState() => _ScanQrcodePageState();
}

class _ScanQrcodePageState extends State<ScanQrcodePage> {
  late OwnThemeFields themeOwn;
  final ScanQrcodeController scanQRCodeController = Get.find<ScanQrcodeController>();
  final OutletDetailController outletDetailController = Get.find<OutletDetailController>();

  @override
  void initState() {
    super.initState();
    scanQRCodeController.bindingData(outletId: outletDetailController.outletDetail.value.outletId!);
  }

  @override
  Widget build(BuildContext context) {
    themeOwn = Theme.of(context).own();
    return Scaffold(
      appBar: _appBar(),
      body: GetBuilder<ScanQrcodeController>(
        init: scanQRCodeController,
        builder: (controller) {
          if(scanQRCodeController.isPageLoading.value) {
            Container(
              color: themeOwn.dividerColor.withOpacity(0.5),
              child: Center(child: CircularProgressIndicator(
                color: themeOwn.mainColor,
              ),),
            );
          }
          if(scanQRCodeController.scanQrcodeModel.value.assetStatus! < 0 || scanQRCodeController.reScan.value==true) {
            return ScanQrcodeScreen(themeOwn: themeOwn, controller: controller);
          }
          return Stack(
            children: [
              _buildBody(context),
              if(scanQRCodeController.isPageLoading.value)
                Container(
                  color: themeOwn.dividerColor.withOpacity(0.5),
                  child: Center(child: CircularProgressIndicator(
                    color: themeOwn.mainColor,
                  ),),
                ),
            ],
          );
        }
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppString.scanQrcode,
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
      actions: [
        GetBuilder<ScanQrcodeController>(
          init: scanQRCodeController,
          builder: (controller) => _reScan(),
        ),
      ],
    );
  }

  Widget _reScan() {
    if(!scanQRCodeController.isReadOnly && scanQRCodeController.scanQrcodeModel.value.isScan! && scanQRCodeController.reScan.value==false) {
      return InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () async {
          scanQRCodeController.reScan.value=true;
          scanQRCodeController.update();
          /*final result = await Get.toNamed(ScanQrcodePage.route);
          if(result == null) return;
          scanQRCodeController.checkScan(qrcode: result);*/
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: NumberConstant.basePaddingMedium),
            child: Row(
              children: [
                SvgPicture.asset(
                  assetIconsPath + iconQrcodeSvg,
                  width: _Constant.sizeIconAppbar,
                  height: _Constant.sizeIconAppbar,
                  color: AppColor.appColorYellow2,
                  fit: BoxFit.fill,
                ),
                const SizedBox(width: NumberConstant.basePaddingSmall,),
                Text(AppString.reScanQrcode,
                  style: AppTextStyle.textStyleAppBar.copyWith(
                    color: AppColor.appColorYellow2,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Container();
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: NumberConstant.basePaddingMedium,
                    horizontal: NumberConstant.basePaddingLarge,
                  ),
                  child: _headerWidget(context),
                ),
                _noteWidget(context),
                _assetWidget(context),
                _outletInformationWidget(context),
                const SizedBox(height: NumberConstant.marginInfo,),
              ],
            ),
          ),
        ),
        if(outletDetailController.selectedOutletDetail != SelectedOutletDetailEnum.VIEW)
          _bottomButton(context),
      ],
    );
  }

  Widget _headerWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: NumberConstant.basePaddingMedium),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: NumberConstant.basePaddingSmall),
                child: SvgPicture.asset(
                  assetIconsPath + iconSquareSvg,
                  color: AppColor.appColorDark3,
                  fit: BoxFit.fill,
                ),
              ),
              Text(_Constant.coolerSerialCode,
                style: AppTextStyle.textStyleListDefault,
              ),
              const Spacer(),
              Text(scanQRCodeController.scanQrcodeModel.value.scanCode ?? '',
                style: AppTextStyle.textStyleListDefault.copyWith(
                  color: scanQRCodeController.scanStatus.color(),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: NumberConstant.basePaddingMedium),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: NumberConstant.basePaddingSmall),
                child: SvgPicture.asset(
                  assetIconsPath + iconRefrigeratorSvg,
                  color: AppColor.appColorDark3,
                  fit: BoxFit.fill,
                ),
              ),
              Text(_Constant.coolerStatus,
                style: AppTextStyle.textStyleListDefault,
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: scanQRCodeController.scanStatus.color(),
                  borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
                ),
                padding: const EdgeInsets.all(NumberConstant.basePaddingSmall),
                child: Text(scanQRCodeController.scanStatus.name(),
                  style: themeOwn.textStyleDetailDescription!.copyWith(color: Colors.white),),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _noteWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: NumberConstant.basePaddingLarge,
          ),
          child: Text(_Constant.note,
            style: themeOwn.textStyleHeaderDefault,
          ),
        ),
        const Divider(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: NumberConstant.baseRadiusBorderLarge),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: _Constant.hintNote,
              hintStyle: themeOwn.textStyleHint,
            ),
            style: themeOwn.textStyleDefault,
            minLines: _Constant.minHeadline,
            maxLines: _Constant.maxHeadline,
            controller: scanQRCodeController.noteEditController,
            enabled: !scanQRCodeController.isReadOnly,
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _assetWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: NumberConstant.basePaddingMedium,
            horizontal: NumberConstant.basePaddingLarge,
          ),
          child: Text(_Constant.asset,
            style: themeOwn.textStyleHeaderDefault,
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: NumberConstant.basePaddingLarge,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: NumberConstant.basePaddingMedium),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: NumberConstant.basePaddingSmall),
                      child: SvgPicture.asset(
                        assetIconsPath + iconSquareSvg,
                        color: AppColor.appColorDark3,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(_Constant.assetCode,
                      style: AppTextStyle.textStyleListDefault,
                    ),
                    const Spacer(),
                    Text(scanQRCodeController.scanQrcodeModel.value.serialNumber ?? AppString.none,
                      style: AppTextStyle.textStyleListDefault,
                    ),
                  ],
                ),
              ),
              // const Divider(),
              if(false)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: NumberConstant.basePaddingMedium),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: NumberConstant.basePaddingSmall),
                        child: SvgPicture.asset(
                          assetIconsPath + iconRefrigeratorSvg,
                          color: AppColor.appColorDark3,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(_Constant.assetStatus,
                        style: AppTextStyle.textStyleListDefault,
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: scanQRCodeController.scanStatus.color(),
                          borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
                        ),
                        padding: const EdgeInsets.all(NumberConstant.basePaddingSmall),
                        child: Text(scanQRCodeController.scanStatus == ScanStatusEnum.SUCCESS
                            ? _Constant.matching : _Constant.notMatching,
                          style: themeOwn.textStyleDetailDescription!.copyWith(color: Colors.white),),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _outletInformationWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: NumberConstant.basePaddingMedium,
            horizontal: NumberConstant.basePaddingLarge,
          ),
          child: Text(_Constant.outletInformation,
            style: themeOwn.textStyleHeaderDefault,
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: NumberConstant.basePaddingLarge,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: NumberConstant.basePaddingMedium),
                child: Row(
                  children: [
                    Container(
                      height: _Constant.sizeIconOutletInfo,
                      width: _Constant.sizeIconOutletInfo,
                      decoration: BoxDecoration(
                        color: AppColor.appColorLight2,
                        borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
                      ),
                      margin: const EdgeInsets.only(right: NumberConstant.basePaddingMedium),
                      child: Center(
                        child: SvgPicture.asset(
                          assetIconsPath + iconStoreSvg,
                          width: NumberConstant.baseSizeIconSmall,
                          color: AppColor.appColorDark3,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${outletDetailController.outletDetail.value.code?.toString() ?? AppString.none}'
                              ' - ${outletDetailController.outletDetail.value.name ?? AppString.none}',
                            style: themeOwn.textStyleListTitle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: NumberConstant.basePaddingMedium),
                child: Row(
                  children: [
                    Container(
                      height: _Constant.sizeIconOutletInfo,
                      width: _Constant.sizeIconOutletInfo,
                      decoration: BoxDecoration(
                        color: AppColor.appColorLight2,
                        borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
                      ),
                      margin: const EdgeInsets.only(right: NumberConstant.basePaddingMedium),
                      child: Center(
                        child: SvgPicture.asset(
                          assetIconsPath + iconLocationSvg,
                          width: NumberConstant.baseSizeIconSmall,
                          color: AppColor.appColorDark3,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(outletDetailController.outletDetail.value.address ?? AppString.none,
                            style: themeOwn.textStyleListTitle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: NumberConstant.basePaddingMedium),
                child: Row(
                  children: [
                    Container(
                      height: _Constant.sizeIconOutletInfo,
                      width: _Constant.sizeIconOutletInfo,
                      decoration: BoxDecoration(
                        color: AppColor.appColorLight2,
                        borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
                      ),
                      margin: const EdgeInsets.only(right: NumberConstant.basePaddingMedium),
                      child: Center(
                        child: Icon(
                          Icons.phone,
                          color: AppColor.appColorDark3,
                          size: NumberConstant.baseSizeIconSmall,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(outletDetailController.outletDetail.value.phone ?? AppString.none,
                            style: themeOwn.textStyleListTitle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _bottomButton(BuildContext context) {
    return RawMaterialButton(
      fillColor: AppColor.mainColor,
      onPressed: () async {
        await scanQRCodeController.saveStep(isUpdate: outletDetailController.steps[0].status == 1);
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
