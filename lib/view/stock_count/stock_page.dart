import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/utlis/utils.dart';
import '../../common/common.dart';
import '../../controller/home_controller.dart';
import '../../controller/outlet_detail_controller.dart';
import '../../controller/stock_controller.dart';
import '../../model/entities.dart';

class _Constant {
  static const sizeProductImage = 50.0;
  static const stepPage = '3/4 steps';
  static const checkingStockAvailable = 'Kiểm tra tồn kho';
  static const item = 'Sản phẩm';
  static const standard = 'Tiêu chuẩn:';
  static const face = 'Mặt';
  static const layer = 'Lớp';
  static const total = 'Tổng';
  static const maxLine = 1;
  static const maxCharacter = 4;
}

class StockPage extends StatefulWidget {
  static const route = '/stock';

  const StockPage({Key? key}) : super(key: key);

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  late OwnThemeFields themeOwn;
  final OutletDetailController outletDetailController = Get.find<OutletDetailController>();
  StockController stockCountController = Get.find<StockController>();
  final answerEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
    stockCountController.bindingData(outletId: outletDetailController.outletDetail.value.outletId!);

  }

  @override
  Widget build(BuildContext context) {
    themeOwn = Theme.of(context).own();
    return Scaffold(
      appBar: _appBar(),
      body: GetBuilder<StockController>(
          init: stockCountController,
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
          Text(AppString.stockCount,
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
                controller: stockCountController.controller,
                child: Column(
                  children: [
                    _headerWidget(context),
                    _listStockCountWidget(context),
                    const SizedBox(height: NumberConstant.marginInfo,),
                  ],
                ),
              ),
            ),
            if(outletDetailController.selectedOutletDetail != SelectedOutletDetailEnum.VIEW)
              _bottomButton(context),
          ],
        ),
        if(stockCountController.isPageLoading.value)
          Container(
            color: themeOwn.dividerColor.withOpacity(0.5),
            child: Center(child: CircularProgressIndicator(
              color: themeOwn.mainColor,
            )),
          )
      ],
    );
  }

  Widget _headerWidget(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColor.appColorLight2,
          height: NumberConstant.heightBanner,
          child: Center(
            child: CachedNetworkImage(
              placeholder: (context, url) => Container(
                color: themeOwn.dividerColor,
                child: Center(
                  child: CircularProgressIndicator(color: themeOwn.mainColor,),
                ),
              ),
              errorWidget: (context, url, error) => SizedBox(
                height: _Constant.sizeProductImage,
                width: _Constant.sizeProductImage,
                child: SvgPicture.asset(
                  assetIconsPath + iconImageSvg,
                  color: themeOwn.dividerColor,
                  fit: BoxFit.contain,
                ),
              ),
              imageUrl: stockCountController.planogramPicture,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(NumberConstant.basePaddingLarge),
          child: Row(
            children: [
              Text(_Constant.checkingStockAvailable,
                style: themeOwn.textStyleDetailTitle!.copyWith(color: themeOwn.subTextColor),
              ),
              const Spacer(),
              Text('${stockCountController.stockCountModel.value.stocks.length} ${_Constant.item}',
                style: themeOwn.textStyleDetailTitle!.copyWith(color: themeOwn.subTextColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _listStockCountWidget(BuildContext context) {
    if(stockCountController.stockCountModel.value.stocks.isEmpty) return Container();
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: stockCountController.stockCountModel.value.stocks.length,
      itemBuilder: (context, index) {
        return _itemStockCount(index);
      },
    );
  }

  Widget _itemStockCount(int index) {
    return Column(
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: NumberConstant.basePaddingMedium,
            horizontal: NumberConstant.basePaddingLarge,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: _Constant.sizeProductImage,
                    width: _Constant.sizeProductImage,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderMedium),
                      child: CachedNetworkImage(
                        placeholder: (context, url) => Container(
                          color: themeOwn.dividerColor,
                          padding: const EdgeInsets.all(NumberConstant.basePaddingMedium),
                          child: CircularProgressIndicator(color: themeOwn.mainColor,),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: _Constant.sizeProductImage,
                          width: _Constant.sizeProductImage,
                          decoration: BoxDecoration(
                            color: AppColor.appColorLight2,
                            borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderMedium),
                            border: Border.all(
                              width: 1,
                              color: themeOwn.dividerColor,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(NumberConstant.basePaddingMedium),
                            child: SvgPicture.asset(
                              assetIconsPath + iconImageSvg,
                              color: themeOwn.dividerColor,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        imageUrl: stockCountController.stockCountModel.value.stocks[index].stockPicture ?? '',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: NumberConstant.basePaddingMedium,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(stockCountController.stockCountModel.value.stocks[index].stockName ?? AppString.none,
                      style: themeOwn.textStyleListTitle,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: NumberConstant.basePaddingLarge),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_Constant.standard,
                            style: themeOwn.textStyleListTitle!.copyWith(color: themeOwn.subTextColor),
                          ),
                          Text('${stockCountController.stockCountModel.value.stocks[index].face} ${_Constant.face}',
                            style: themeOwn.textStyleListTitle!.copyWith(color: themeOwn.subTextColor),
                          ),
                          Text('${stockCountController.stockCountModel.value.stocks[index].layer} ${_Constant.layer}',
                            style: themeOwn.textStyleListTitle!.copyWith(color: themeOwn.subTextColor),
                          ),
                          Text('${stockCountController.stockCountModel.value.stocks[index].total} ${_Constant.total}',
                            style: themeOwn.textStyleListTitle!.copyWith(color: themeOwn.subTextColor),
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
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: NumberConstant.basePaddingLarge                                           ,
          ),
          child: Row(
            children: [
              SizedBox(
                height: _Constant.sizeProductImage,
                width: _Constant.sizeProductImage,
                child: (stockCountController.stockCountModel.value.stocks[index].faceInput == -1
                    || stockCountController.stockCountModel.value.stocks[index].totalInput == -1)
                    ? Center(
                  child: SvgPicture.asset(
                    assetIconsPath + iconWarningSvg,
                    width: NumberConstant.baseSizeIconSmall,
                    fit: BoxFit.fill,
                  ),
                ) : Container(),
              ),
              const SizedBox(width: NumberConstant.basePaddingMedium,),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: NumberConstant.basePaddingMedium),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: outletDetailController.homeController.configModel.value.outletStockCountCheck==1? (stockCountController.stockCountModel.value.stocks[index].faceInput == -1 ? themeOwn.errorColor : themeOwn.dividerColor):themeOwn.dividerColor,
                    ),
                    borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(
                                top: NumberConstant.basePaddingMedium,
                                bottom: NumberConstant.basePaddingMedium,
                                right: NumberConstant.basePaddingMedium
                            ),
                            hintText: '-',
                            hintStyle: themeOwn.textStyleHeaderDefault,
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(_Constant.maxCharacter),
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLines: _Constant.maxLine,
                          controller: stockCountController.facesEditControllers[index],
                          style: themeOwn.textStyleHeaderDefault,
                          onChanged: (text) {
                            stockCountController.updateFace(index: index);
                          },
                          enabled: !stockCountController.isReadOnly,
                        ),
                      ),
                      Text(_Constant.face,
                        style: themeOwn.textStyleListDetail,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: NumberConstant.basePaddingLarge,),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: NumberConstant.basePaddingMedium),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:outletDetailController.homeController.configModel.value.outletStockCountCheck==1? (stockCountController.stockCountModel.value.stocks[index].totalInput == -1 ? themeOwn.errorColor : themeOwn.dividerColor): themeOwn.dividerColor,
                    ),
                    borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(
                                top: NumberConstant.basePaddingMedium,
                                bottom: NumberConstant.basePaddingMedium,
                                right: NumberConstant.basePaddingMedium
                            ),
                            hintText: '-',
                            hintStyle: themeOwn.textStyleHeaderDefault,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(_Constant.maxCharacter),
                          ],
                          maxLines: _Constant.maxLine,
                          controller: stockCountController.totalsEditControllers[index],
                          style: themeOwn.textStyleHeaderDefault,
                          onChanged: (text) {
                            stockCountController.updateTotal(index: index);
                          },
                          enabled: !stockCountController.isReadOnly,
                        ),
                      ),
                      Text(_Constant.total,
                        style: themeOwn.textStyleListDetail,
                      ),
                    ],
                  ),
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
      onPressed: () {
        stockCountController.saveStep(
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
