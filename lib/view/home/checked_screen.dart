import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../app/utlis/utils.dart';
import '../../common/common.dart';
import '../../controller/home_controller.dart';
import '../../model/entities.dart';
import '../../model/outlet/outlet_model.dart';

class _Constant {
  static double paddingChecked = 4.0;
  static double sizeWidthLocationItem = 100;
  static double sizeEmptyIcon = 100;
  static title(int number) => 'Đã viếng thăm $number cửa hàng';
}

class CheckedScreen extends StatefulWidget {
  const CheckedScreen({Key? key}) : super(key: key);

  @override
  State<CheckedScreen> createState() => _CheckedScreenState();
}

class _CheckedScreenState extends State<CheckedScreen> {
  late OwnThemeFields themeOwn;
  HomeController homeController = Get.find<HomeController>();
  final RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
  }

  void _onRefresh() async{
    await homeController.refreshOutlet();
    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    themeOwn = Theme.of(context).own();
    return GetBuilder<HomeController>(
        init: homeController,
        builder: (controller) {
          return Obx(() {
            if(homeController.checkedOutlets.isEmpty) {
              return _emptyWidget();
            }
            if(homeController.searchCheckedOutlets.isNotEmpty) {
              return _buildBody(homeController.searchCheckedOutlets);
            }
            return _buildBody(homeController.checkedOutlets);
          });
        }
    );
  }

  Widget _buildBody(List<OutletModel> list) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: false,
      onRefresh: _onRefresh,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: NumberConstant.basePaddingMedium),
            child: _item(list[index]),
          );
        },
        itemCount: list.length,
      ),
    );
  }

  Widget _emptyWidget() {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: false,
      onRefresh: _onRefresh,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            assetImagePath + noneNearby,
            width: _Constant.sizeEmptyIcon,
            height: _Constant.sizeEmptyIcon,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.all(NumberConstant.basePaddingMedium),
            child: Text(AppString.noFound,
              style: themeOwn.textStyleDetailTitle!.copyWith(color: themeOwn.subTextColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(OutletModel outlet) {
    return Container(
      padding: const EdgeInsets.all(NumberConstant.basePaddingMedium,),
      margin: const EdgeInsets.symmetric(vertical: NumberConstant.basePaddingMedium,),
      decoration: BoxDecoration(
        color: outlet.distance! <= homeController.configModel.value.distance!
            ? outlet.currentStatus == CheckInStatusEnum.CHECKOUT.name()
            ? AppColor.checkedBackgroundColor : outlet.currentStatus == CheckInStatusEnum.CHECKIN.name()
            ? AppColor.inprogressBackgroundColor : Colors.white
            : AppColor.wrongLocationBackgroundColor,
        borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
        border: Border.all(
          color: outlet.distance! <= homeController.configModel.value.distance!
              ? outlet.currentStatus == CheckInStatusEnum.CHECKOUT.name()
              ? AppColor.checkedBorderColor : outlet.currentStatus == CheckInStatusEnum.CHECKIN.name()
              ? AppColor.inprogressBorderColor : Colors.grey.withOpacity(0.2)
              :AppColor.wrongLocationBorderColor,
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  if(outlet.currentStatus == CheckInStatusEnum.CHECKOUT.name()) {
                    await homeController.viewOutletDetail(outlet: outlet);
                  }else {
                    homeController.selectOutlet(outlet: outlet);
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${outlet.code?.toString() ?? AppString.none} - ${outlet.name ?? AppString.none}',
                      style: themeOwn.textStyleListTitle,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: NumberConstant.basePaddingMedium),
                      child: Text(outlet.address ?? AppString.none,
                        style: themeOwn.textStyleListDetail,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: NumberConstant.basePaddingMedium),
                      child: Text('${AppString.phone}: ${outlet.phone ?? AppString.none}',
                        style: themeOwn.textStyleListDetail,
                      ),
                    ),

                    if((outlet.coolerStatus!.isNotEmpty))
                      Padding(
                        padding: const EdgeInsets.only(top: NumberConstant.basePaddingMedium),
                        child: Container(
                          decoration: BoxDecoration(
                            color: outlet.coolerStatus == ScanStatusEnum.SUCCESS.name()
                                ? ScanStatusEnum.SUCCESS.color() : outlet.coolerStatus == ScanStatusEnum.FAIL.name()
                                ? ScanStatusEnum.FAIL.color() :  outlet.coolerStatus == ScanStatusEnum.DAMAGE.name()
                                ? ScanStatusEnum.DAMAGE.color() : ScanStatusEnum.MISSING.color(),
                            borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
                          ),
                          padding: EdgeInsets.all(_Constant.paddingChecked),
                          child: Text(outlet.coolerStatus?? '',
                            style: themeOwn.textStyleListDetail!.copyWith(color: Colors.white),),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            VerticalDivider(
              color: themeOwn.dividerColor,
              thickness: 1,
            ),
            Center(
              child: InkWell(
                onTap: () async {
                  await homeController.openMap(outletModel: outlet);
                },
                child: SizedBox(
                  width: _Constant.sizeWidthLocationItem,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_pin, color: AppColor.appColorDark3,),
                              Text(outlet.distance! <= 1000.0
                                  ? '${outlet.distance}m' : Utils.exchangeDistance(distance: outlet.distance!) <= 999
                                  ? '${Utils.exchangeDistance(distance: outlet.distance!)}km' : AppString.numOverDistance,
                                style: themeOwn.textStyleListDetail,
                              ),
                            ],
                          ),
                        ],
                      ),
                      if(outlet.currentStatus?.isNotEmpty ?? false)
                        Padding(
                          padding: const EdgeInsets.only(top: NumberConstant.basePaddingMedium),
                          child: Row(
                            children: [
                              Image.asset(outlet.currentStatus == CheckInStatusEnum.CHECKOUT.name()
                                  ? assetIconsPath + iconCheckedStatus : outlet.currentStatus == CheckInStatusEnum.CHECKIN.name()
                                  ? assetIconsPath + iconInprogressStatus : outlet.currentStatus == CheckInStatusEnum.CHECKIN_ERROR.name()
                                  ? assetIconsPath + iconWarningStatus : '',
                                color: outlet.currentStatus == CheckInStatusEnum.CHECKOUT.name()
                                    ? AppColor.checkedColor : outlet.currentStatus == CheckInStatusEnum.CHECKIN.name()
                                    ? AppColor.inProgressColor : outlet.currentStatus == CheckInStatusEnum.CHECKIN_ERROR.name()
                                    ? AppColor.errorColor : Colors.transparent,
                                width: NumberConstant.baseSizeIconSmall,
                                height: NumberConstant.baseSizeIconSmall,
                                fit: BoxFit.fill,
                              ),
                              Text(outlet.currentStatus == CheckInStatusEnum.CHECKOUT.name()
                                  ? ' at ${DateFormat("hh:mm:ss").parse(outlet.checkOutTime!).toStringWithFormat(format: DateTimeConstant.hourMeridian,)!}'
                                  : ' at ${DateFormat("hh:mm:ss").parse(outlet.checkInTime!).toStringWithFormat(format: DateTimeConstant.hourMeridian,)!}' ,
                                style: themeOwn.textStyleListDetail,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
