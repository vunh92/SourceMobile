import 'package:cached_network_image/cached_network_image.dart';
import 'package:cooler_mdlz/controller/outlet_detail_controller.dart';
import 'package:cooler_mdlz/service/remote_service.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../app/utlis/utils.dart';
import '../../common/common.dart';
import '../../controller/home_controller.dart';
import '../../model/entities.dart';
import '../../widgets/image_full_screen_widget.dart';

class _Constant {
  static const sizeIconStep2 = 31.0;
  static const sizeIcon = 20.0;
  static const currentDistance = "Khoảng cách hiện tại";
  static const status = "Trạng thái";
  static const stepsBelow = "Để viếng thăm CH hãy thực hiện các bước dưới đây";
}

class OutletDetailPage extends StatefulWidget {
  static const route = '/outlet_detail';

  const OutletDetailPage({Key? key}) : super(key: key);

  @override
  State<OutletDetailPage> createState() => _OutletDetailPageState();
}

class _OutletDetailPageState extends State<OutletDetailPage> {
  late OwnThemeFields themeOwn;
  final HomeController homeController = Get.find<HomeController>();
  final OutletDetailController outletDetailController = Get.find<OutletDetailController>();
 var outletPicture="";
  @override
  void initState() {
    super.initState();
    outletDetailController.selectedOutletDetail = Get.arguments;
    outletDetailController.bindingData(outletModel: homeController.outletModel.value);
    outletPicture=homeController.configModel.value.outletPicture!.replaceAll(
        RegExp('~'), RemoteServices.host);
    if(homeController.outletModel.value.outletPicture!=null && homeController.outletModel.value.outletPicture!.isNotEmpty)
    {
      outletPicture = homeController.outletModel.value.outletPicture!.replaceAll(
          RegExp('~'), RemoteServices.host);
    }
  }

  @override
  Widget build(BuildContext context) {
    themeOwn = Theme.of(context).own();
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: GetBuilder<OutletDetailController>(
        init: outletDetailController,
        builder: (controller) {
          return _buildBody(context);
        }
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _outletInfoWidget(context),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: NumberConstant.basePaddingLarge),
                child: _distanceWidget(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: NumberConstant.basePaddingLarge),
                child: _stepsWidget(context),
              ),
              const SizedBox(height: NumberConstant.marginInfo,),
              if((homeController.outletModel.value.currentStatus == CheckInStatusEnum.CHECKIN.name()
                  && !outletDetailController.isPageLoading.value)
                  || outletDetailController.scanCoolerMissing.value)
                RawMaterialButton(
                  fillColor: (!outletDetailController.validatedCheckout.value && outletDetailController.coolerMissing.value==false)
                      ? AppColor.mainColor.withOpacity(0.5) : AppColor.mainColor ,
                  onPressed: (!outletDetailController.validatedCheckout.value && outletDetailController.coolerMissing.value==false)
                      ? null
                      : () {
                    if(outletDetailController.scanCoolerMissing.value) {
                      outletDetailController.checkOutMissingCooler();
                    }else {
                      outletDetailController.checkOutOutlet();
                    }
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(NumberConstant.basePaddingLarge),
                      child: Text(
                        AppString.checkOut,
                        style: themeOwn.textStyleMainButton!.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        if(outletDetailController.isPageLoading.value)
          Container(
            color: themeOwn.dividerColor.withOpacity(0.5),
            child: Center(child: CircularProgressIndicator(
              color: themeOwn.mainColor,
            )),
          )
      ],
    );
  }

  Widget _outletInfoWidget(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColor.appColorLight2,
          height: NumberConstant.heightBanner + NumberConstant.marginInfo*2,
          margin: const EdgeInsets.only(bottom: NumberConstant.marginInfo),
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Get.toNamed(ImageFullScreenWidget.route, arguments: outletPicture);
            },
            child: Center(
              child: CachedNetworkImage(
                placeholder: (context, url) => Container(
                  color: themeOwn.dividerColor,
                  child: Center(
                    child: CircularProgressIndicator(color: themeOwn.mainColor,),
                  ),
                ),
                errorWidget: (context, url, error) => SizedBox(
                  height: NumberConstant.sizeProductImage,
                  width: NumberConstant.sizeProductImage,
                  child: SvgPicture.asset(
                    assetIconsPath + iconImageSvg,
                    color: themeOwn.dividerColor,
                    fit: BoxFit.contain,
                  ),
                ),
                imageUrl: outletPicture,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(NumberConstant.basePaddingLarge),
            margin: const EdgeInsets.all(NumberConstant.basePaddingLarge),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
              boxShadow: [
                BoxShadow(
                    color: AppColor.shadowColor,
                    blurRadius: NumberConstant.baseRadiusBorderSmall,
                    offset: const Offset(0.0, 2.0)
                ),
              ],
            ),
            child: Column(
              children: [
                Text('${homeController.outletModel.value.code?.toString() ?? AppString.none}'
                    ' - ${homeController.outletModel.value.name ?? AppString.none}',
                  style: themeOwn.textStyleHeaderTitle,
                ),
                const SizedBox(height: NumberConstant.baseRadiusBorderSmall,),
                Text(homeController.outletModel.value.address ?? AppString.none,
                  style: themeOwn.textStyleHeaderDescription,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _distanceWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: NumberConstant.basePaddingMedium),
          child: Row(
            children: [
              Container(
                width: _Constant.sizeIcon,
                margin: const EdgeInsets.only(right: NumberConstant.basePaddingSmall),
                child: SvgPicture.asset(
                  assetIconsPath + iconLocationSvg,
                  width: _Constant.sizeIcon,
                  color: AppColor.appColorDark3,
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                _Constant.currentDistance,
                style: AppTextStyle.textStyleListDefault,
              ),
              const Spacer(),
              Text(homeController.outletModel.value.distance! <= 1000.0
                  ? '${homeController.outletModel.value.distance}m' : Utils.exchangeDistance(distance: homeController.outletModel.value.distance!) <= 999
                  ? '${Utils.exchangeDistance(distance: homeController.outletModel.value.distance!)}km' : AppString.numOverDistance,
                style: AppTextStyle.textStyleListDefault,
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
                width: _Constant.sizeIcon,
                margin: const EdgeInsets.only(right: NumberConstant.basePaddingSmall),
                child: SvgPicture.asset(
                  assetIconsPath + iconStoreSvg,
                  width: _Constant.sizeIcon,
                  color: AppColor.appColorDark3,
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                _Constant.status,
                style: AppTextStyle.textStyleListDefault,
              ),
              const Spacer(),
              Row(
                children: [
                  if(homeController.outletModel.value.currentStatus != null && homeController.outletModel.value.currentStatus!.isNotEmpty)
                    Text('at ${homeController.outletModel.value.currentStatus == CheckInStatusEnum.CHECKOUT.name()
                        ? DateFormat("hh:mm:ss").parse(homeController.outletModel.value.checkOutTime!).toStringWithFormat(format: DateTimeConstant.hourMeridian,)
                        : DateFormat("hh:mm:ss").parse(homeController.outletModel.value.checkInTime!).toStringWithFormat(format: DateTimeConstant.hourMeridian,)}',
                      style: themeOwn.textStyleListDetail,
                    ),
                  const SizedBox(width: NumberConstant.basePaddingSmall,),
                  Container(
                    decoration: BoxDecoration(
                      color: homeController.outletModel.value.currentStatus == CheckInStatusEnum.CHECKOUT.name()
                          ? AppColor.checkedColor
                          : homeController.outletModel.value.currentStatus == CheckInStatusEnum.CHECKIN.name()
                          ? AppColor.inProgressColor
                          : homeController.outletModel.value.currentStatus == CheckInStatusEnum.CHECKIN_ERROR.name()
                          ? AppColor.errorColor : AppColor.unCheckedColor,
                      borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
                    ),
                    padding: const EdgeInsets.all(NumberConstant.basePaddingSmall),
                    child: Text(homeController.outletModel.value.currentStatus == CheckInStatusEnum.CHECKOUT.name()
                        ? AppString.checked
                        : homeController.outletModel.value.currentStatus == CheckInStatusEnum.CHECKIN.name()
                        ? AppString.inProgress
                        : homeController.outletModel.value.currentStatus == CheckInStatusEnum.CHECKIN_ERROR.name()
                        ? AppString.wrongLocation : AppString.unChecked,
                      style: themeOwn.textStyleDetailDescription!.copyWith(color: Colors.white),),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(),
        if(((outletDetailController.selectedOutletDetail == SelectedOutletDetailEnum.REVISIT && homeController.outletModel.value.currentStatus == CheckInStatusEnum.CHECKOUT.name())
            || (homeController.outletModel.value.currentStatus == CheckInStatusEnum.CHECKIN_ERROR.name() || homeController.outletModel.value.currentStatus == ''))
            && ((homeController.configModel.value.outletStockCountCheck == 1 && outletDetailController.coolerModel.value.stocks.isNotEmpty) || homeController.configModel.value.outletStockCountCheck==0)
            && !outletDetailController.isPageLoading.value)
          RawMaterialButton(
            fillColor: AppColor.mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
            ),
            onPressed: () async {
              await outletDetailController.checkInOutlet();
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(NumberConstant.basePaddingLarge),
                child: Text(AppString.checkIn,
                  style: themeOwn.textStyleMainButton!.copyWith(color: Colors.white),
                ),
            ),),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: NumberConstant.basePaddingLarge),
              child: Text(
                _Constant.stepsBelow,
                style: themeOwn.textStyleDetailDescription,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _stepsWidget(BuildContext context) {
    if(outletDetailController.steps.isEmpty) return const SizedBox();
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: _Constant.sizeIconStep2 / 2 + NumberConstant.basePaddingMedium,
            left: _Constant.sizeIconStep2 / 2,
          ),
          height: (_Constant.sizeIconStep2 + NumberConstant.basePaddingMedium * 2) * outletDetailController.steps.length,
          child: DottedLine(
            direction: Axis.vertical,
            dashLength: 2.5,
            dashGapLength: 1.5,
            dashColor: AppColor.appColorDark4,
          ),
        ),
        Column(
          children: [
            _stepRowWidget(
              isChecked: outletDetailController.steps[0].status == 1,
              step: '1',
              icon: assetIconsPath + iconQrcodeSvg,
              name: AppString.scanQrcode,
              isRequired: true,
              enable: homeController.outletModel.value.currentStatus == CheckInStatusEnum.CHECKIN.name()
                  && (outletDetailController.coolerModel.value.serialNumber?.isNotEmpty ?? false),
            ),
            _stepRowWidget(
              isChecked: outletDetailController.steps[1].status == 1,
              step: '2',
              icon: assetIconsPath + iconImageSvg,
              name: AppString.hotZone,
              isRequired: outletDetailController.steps[1].isRequired == 1,
              enable: outletDetailController.outletDetail.value.currentStatus == CheckInStatusEnum.CHECKIN.name()
                  && outletDetailController.steps[0].status == 1
                  && (outletDetailController.coolerModel.value.serialNumber?.isNotEmpty ?? false)
                  && !outletDetailController.scanCoolerMissing.value,
            ),
            // _stepRowWidget(
            //   isChecked: outletDetailController.steps[2].status == 1,
            //   step: '3',
            //   icon: assetIconsPath + iconCalculatorSvg,
            //   name: AppString.stockCount,
            //   isRequired: outletDetailController.steps[2].isRequired == 1,
            //   enable: outletDetailController.outletDetail.value.currentStatus == CheckInStatusEnum.CHECKIN.name()
            //       && outletDetailController.steps[1].status == 1
            //       && (outletDetailController.coolerModel.value.serialNumber?.isNotEmpty ?? false)
            //       && !outletDetailController.scanCoolerMissing.value,
            // ),
            _stepRowWidget(
              isChecked: outletDetailController.steps[2].status == 1,
              step: '3',
              icon: assetIconsPath + iconSettingSvg,
              name: AppString.maintenance,
              isRequired: false,
              enable: outletDetailController.outletDetail.value.currentStatus == CheckInStatusEnum.CHECKIN.name()
                  && outletDetailController.steps[1].status == 1
                  && (outletDetailController.coolerModel.value.serialNumber?.isNotEmpty ?? false)
                  && !outletDetailController.scanCoolerMissing.value,
            ),
          ],
        ),
      ],
    );
  }

  Widget _iconRoundStep(bool isChecked, String numStep ) {
    return isChecked
        ? Container(
      width: _Constant.sizeIconStep2,
      height: _Constant.sizeIconStep2,
      color: Colors.white,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(_Constant.sizeIconStep2),
        color: AppColor.checkedColor,
        strokeCap: StrokeCap.round,
        child: Center(
          child: SvgPicture.asset(assetIconsPath + iconCheckedSvg),
        ),
      ),
    )
        : Container(
      width: _Constant.sizeIconStep2,
      height: _Constant.sizeIconStep2,
      color: Colors.white,
          child: DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(_Constant.sizeIconStep2),
      color: AppColor.appColorDark4,
      child: Center(
        child: Text(
          numStep,
          style: themeOwn.textStyleDetailDescription,
        ),
      ),
    ),
        );
  }

  Widget _stepRowWidget({
    required bool isChecked,
    required String step,
    required String icon,
    required String name,
    required bool isRequired,
    required bool enable,
  }){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: NumberConstant.basePaddingMedium),
      child: Row(
        children: [
          _iconRoundStep(isChecked, step),
          DottedLine(
            dashLength: 2.5,
            dashGapLength: 1.5,
            lineLength: _Constant.sizeIconStep2,
            dashColor: AppColor.appColorDark4,
          ),
          Expanded(
            child: InkWell(
              onLongPress: null,
              onTap: () async {
                if(!enable) {
                  return;
                }
                await outletDetailController.selectedStep(step);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColor.appColorLight1),
                  borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderMedium),
                  boxShadow: [
                    BoxShadow(
                        color: AppColor.shadowColor,
                        blurRadius: NumberConstant.baseRadiusBorderMedium,
                        offset: const Offset(0.0, 2.0)
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(NumberConstant.basePaddingMedium),
                  child: Row(
                    children: [
                      Container(
                        width: NumberConstant.baseSizeIconMedium,
                        height: NumberConstant.baseSizeIconMedium,
                        margin: const EdgeInsets.symmetric(horizontal: NumberConstant.basePaddingMedium),
                        child: SvgPicture.asset(
                          icon,
                          width: NumberConstant.baseSizeIconMedium,
                          color: themeOwn.textColorDefault.withOpacity(enable ? 1 : 0.2),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(name,
                        style: themeOwn.textStyleDetailTitle!.copyWith(
                          color: themeOwn.textColorDefault.withOpacity(enable ? 1 : 0.2)
                        ),
                      ),
                      if(isRequired)
                        Text(' *', style: TextStyle(
                          color: AppColor.appColorRed1.withOpacity(enable ? 1 : 0.2),
                        ),),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
