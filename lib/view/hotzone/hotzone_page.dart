import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/utlis/utils.dart';
import '../../common/common.dart';
import '../../controller/hotzone_controller.dart';
import '../../controller/outlet_detail_controller.dart';
import '../../model/entities.dart';
import '../../widgets/image_full_screen_widget.dart';

class _Constant {
  static const heightPicture = 130.0;
  static const sizeProductImage = 50.0;
  static const minHeadline = 7;
  static const maxHeadline = 10;
  static const stepPage = '2/3 steps';
  static const hotzone = 'Hotzone';
  static const takePhotoHotzone = 'Chụp hình ảnh hotzone';
  static const deletePhotoHotzone = 'Bạn muốn xóa hình Hotzone?';
  static const planogram = 'Planogram';
  static const takePhotoPlanogram = 'Chụp hình ảnh Planogram';
  static const deletePhotoPlanogram = 'Bạn muốn xóa hình Planogram?';
  static const survey = 'Khảo sát';
  static const yes = 'Có';
  static const no = 'Không';
  static const question1 = 'Câu hỏi 1';
  static const question2 = 'Câu hỏi 2';
  static const question3 = 'Câu hỏi 3';
  static const question4 = 'Câu hỏi 4';
  static const answer1 = 'Đáp án 1';
  static const answer2 = 'Đáp án 2';
  static const answer3 = 'Đáp án 3';
  static const answer4 = 'Đáp án 4';
  static const hintQuestionReason = 'Nhập câu trả lời';
}

class HotzonePage extends StatefulWidget {
  static const route = '/hotzone';

  const HotzonePage({Key? key}) : super(key: key);

  @override
  State<HotzonePage> createState() => _HotzonePageState();
}

class _HotzonePageState extends State<HotzonePage> {
  late OwnThemeFields themeOwn;
  final HotZoneController hotzoneController = Get.find<HotZoneController>();
  final OutletDetailController outletDetailController = Get.find<OutletDetailController>();

  @override
  void initState() {
    super.initState();
    hotzoneController.bindingData(outletId: outletDetailController.outletDetail.value.outletId!);
  }

  Future<File?> _getFromCamera() async {

    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: NumberConstant.widthDevice(context)*3,
      maxHeight: NumberConstant.heightDevice(context)*3,
      imageQuality: 100,
    );
    if (pickedFile == null) return null;
    return File(pickedFile.path);
  }

  @override
  Widget build(BuildContext context) {
    themeOwn = Theme.of(context).own();
    return Scaffold(
      appBar: _appBar(),
      body: GetBuilder<HotZoneController>(
        init: hotzoneController,
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
          Text(AppString.hotZone,
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
                    _headerWidget(context),
                    _surveyWidget(context),
                    const SizedBox(height: NumberConstant.marginInfo,),
                  ],
                ),
              ),
            ),
            if(outletDetailController.selectedOutletDetail != SelectedOutletDetailEnum.VIEW)
              _bottomButton(context),
          ],
        ),
        if(hotzoneController.isPageLoading.value)
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
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Get.toNamed(ImageFullScreenWidget.route, arguments: hotzoneController.hotZonePicture);
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
                imageUrl: hotzoneController.hotZonePicture,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: NumberConstant.basePaddingLarge,
            horizontal: NumberConstant.basePaddingMedium,
          ),
          child: SizedBox(
            height: _Constant.heightPicture,
            child: Row(
              children: [
                Expanded(
                  child: hotzoneController.hotZoneModel.value.hotZonePicture!.isNotEmpty
                      ? Stack(
                    fit: StackFit.expand,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: NumberConstant.basePaddingMedium,
                          right: NumberConstant.basePaddingMedium,
                          left: NumberConstant.basePaddingMedium,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
                          child: Container(
                            color: Colors.black,
                            child: CachedNetworkImage(
                              placeholder: (context, url) => Container(
                                color: themeOwn.dividerColor,
                                child: Center(
                                  child: CircularProgressIndicator(color: themeOwn.mainColor,),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                decoration: BoxDecoration(
                                  color: AppColor.appColorLight2,
                                  borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderMedium),
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
                              imageUrl: hotzoneController.hotZoneModel.value.hotZonePicture!,
                              fit: BoxFit.contain,
                              height: _Constant.heightPicture,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                      :hotzoneController.hotZoneFile == null
                      ? InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () async {
                      if(hotzoneController.isReadOnly) return;
                      final result = await _getFromCamera();
                      if(result == null) return;
                      hotzoneController.updatePhotoFile(file: result, isHotZone: true);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: NumberConstant.basePaddingMedium,
                        right: NumberConstant.basePaddingMedium,
                        left: NumberConstant.basePaddingMedium,
                      ),
                      child: Container(
                        color: AppColor.appColorLight2,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(NumberConstant.baseRadiusBorderSmall),
                          padding: const EdgeInsets.all(NumberConstant.basePaddingLarge),
                          dashPattern: const <double>[8, 4],
                          color: AppColor.appColorDark4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                assetIconsPath + iconPhotoSvg,
                                color: themeOwn.mainColor,
                                fit: BoxFit.contain,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: NumberConstant.basePaddingSmall),
                                child: Text(_Constant.hotzone,
                                  style: themeOwn.textStyleListTitle,
                                ),
                              ),
                              Text(_Constant.takePhotoHotzone,
                                style: themeOwn.textStyleListDetail,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                      : Stack(
                    fit: StackFit.expand,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: NumberConstant.basePaddingMedium,
                          right: NumberConstant.basePaddingMedium,
                          left: NumberConstant.basePaddingMedium,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
                          child: Container(
                            color: Colors.black,
                            child: Image.file(
                              hotzoneController.hotZoneFile!,
                              fit: BoxFit.contain,
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
                              message: _Constant.deletePhotoHotzone,
                            ));
                            if(!result || hotzoneController.hotZoneFile == null) return;
                            hotzoneController.deletePhotoFile(isHotZone: true);
                          },
                          child: SvgPicture.asset(
                            assetIconsPath + iconCloseSvg,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: hotzoneController.hotZoneModel.value.planogramPicture!.isNotEmpty
                      ? Stack(
                    fit: StackFit.expand,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: NumberConstant.basePaddingMedium,
                          right: NumberConstant.basePaddingMedium,
                          left: NumberConstant.basePaddingMedium,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
                          child: Container(
                            color: Colors.black,
                            child: CachedNetworkImage(
                              placeholder: (context, url) => Container(
                                color: themeOwn.dividerColor,
                                child: Center(
                                  child: CircularProgressIndicator(color: themeOwn.mainColor,),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                decoration: BoxDecoration(
                                  color: AppColor.appColorLight2,
                                  borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderMedium),
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
                              imageUrl: hotzoneController.hotZoneModel.value.planogramPicture!,
                              fit: BoxFit.contain,
                              height: _Constant.heightPicture,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                      : hotzoneController.planogramFile == null
                      ? InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () async {
                      if(hotzoneController.isReadOnly) return;
                      final result = await _getFromCamera();
                      if(result == null) return;
                      hotzoneController.updatePhotoFile(file: result, isHotZone: false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: NumberConstant.basePaddingMedium,
                        right: NumberConstant.basePaddingMedium,
                        left: NumberConstant.basePaddingMedium,
                      ),
                      child: Container(
                        color: AppColor.appColorLight2,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(NumberConstant.baseRadiusBorderSmall),
                          padding: const EdgeInsets.all(NumberConstant.basePaddingLarge),
                          dashPattern: const <double>[8, 4],
                          color: AppColor.appColorDark4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                assetIconsPath + iconPhotoSvg,
                                color: themeOwn.mainColor,
                                fit: BoxFit.fill,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: NumberConstant.basePaddingSmall),
                                child: Text(_Constant.planogram,
                                  style: themeOwn.textStyleListTitle,
                                ),
                              ),
                              Text(_Constant.takePhotoPlanogram,
                                style: themeOwn.textStyleListDetail,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                      : Stack(
                    fit: StackFit.expand,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: NumberConstant.basePaddingMedium,
                          right: NumberConstant.basePaddingMedium,
                          left: NumberConstant.basePaddingMedium,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
                          child: Container(
                            color: Colors.black,
                            child: Image.file(
                              hotzoneController.planogramFile!,
                              fit: BoxFit.contain,
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
                              message: _Constant.deletePhotoPlanogram,
                            ));
                            if(!result || hotzoneController.planogramFile == null) return;
                            hotzoneController.deletePhotoFile(isHotZone: false);
                          },
                          child: SvgPicture.asset(
                            assetIconsPath + iconCloseSvg,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _surveyWidget(BuildContext context) {
    if(hotzoneController.hotZoneModel.value.surveys.isEmpty) return Container();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: NumberConstant.basePaddingLarge,
          ),
          child: Text(hotzoneController.hotZoneModel.value.surveys.first.name ?? _Constant.survey,
            style: themeOwn.textStyleHeaderDefault,
          ),
        ),
        _questionWidget(hotzoneController.hotZoneModel.value.surveys.first.questions),
      ],
    );
  }

  Widget _questionWidget(List<SurveyQuestionModel> questions) {
    if(questions.isEmpty || hotzoneController.isPageLoading.value) return Container();
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: questions.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: NumberConstant.basePaddingMedium,
                horizontal: NumberConstant.basePaddingLarge,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${index + 1}. ${questions[index].questionName!}',
                    style: themeOwn.textStyleListTitle,
                  ),
                  const SizedBox(height: NumberConstant.basePaddingLarge,),
                  if(questions[index].answerType == 1) _answerType1Widget(questions[index], index),
                  if(questions[index].answerType == 2) _answerType2Widget(questions[index], index),
                  if(questions[index].answerType == 3) _answerType3Widget(questions[index], index),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(height: NumberConstant.basePaddingMedium,),
          ],
        );
      },
    );
  }

  Widget _answerType1Widget(SurveyQuestionModel questionModel, int index) {
    return Column(
      children: [
        Row(
          children: [
            if(questionModel.answer1?.isNotEmpty ?? false)
              Expanded(
                child: InkWell(
                  onTap: () {
                    hotzoneController.checkAnswerType1(index: index, result: 1);
                  },
                  child: _answerBoxWidget(
                    name: questionModel.answer1 ?? _Constant.answer1,
                    isChecked: questionModel.isAnswer1Input ?? false,
                    index: index,
                    result: 1,
                    function: hotzoneController.checkAnswerType1,
                  ),
                ),
              ),
            const SizedBox(width: NumberConstant.basePaddingLarge,),
            if(questionModel.answer2?.isNotEmpty ?? false)
              Expanded(
                child: InkWell(
                  onTap: () {
                    hotzoneController.checkAnswerType1(index: index, result: 2);
                  },
                  child: _answerBoxWidget(
                    name: questionModel.answer2 ?? _Constant.answer2,
                    isChecked: questionModel.isAnswer2Input ?? false,
                    index: index,
                    result: 2,
                    function: hotzoneController.checkAnswerType1,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: NumberConstant.basePaddingMedium,),
        Row(
          children: [
            if(questionModel.answer3?.isNotEmpty ?? false)
              Expanded(
                child: InkWell(
                  onTap: () {
                    hotzoneController.checkAnswerType1(index: index, result: 3);
                  },
                  child: _answerBoxWidget(
                    name: questionModel.answer3 ?? _Constant.answer3,
                    isChecked: questionModel.isAnswer3Input ?? false,
                    index: index,
                    result: 3,
                    function: hotzoneController.checkAnswerType1,
                  ),
                ),
              ),
            const SizedBox(width: NumberConstant.basePaddingLarge,),
            if(questionModel.answer4?.isNotEmpty ?? false)
              Expanded(
                child: InkWell(
                  onTap: () {
                    hotzoneController.checkAnswerType1(index: index, result: 4);
                  },
                  child: _answerBoxWidget(
                    name: questionModel.answer4 ?? _Constant.answer4,
                    isChecked: questionModel.isAnswer4Input ?? false,
                    index: index,
                    result: 4,
                    function: hotzoneController.checkAnswerType1,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _answerType2Widget(SurveyQuestionModel questionModel, int index) {
    return Column(
      children: [
        if(questionModel.answer1 != null || questionModel.answer1 != '')
          Padding(
            padding: const EdgeInsets.only(bottom: NumberConstant.basePaddingMedium),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      hotzoneController.checkAnswerType2(index: index, result: 1);
                    },
                    child: _answerBoxWidget(
                      name: questionModel.answer1 ?? _Constant.answer1,
                      isChecked: questionModel.isAnswer1Input ?? false,
                      index: index,
                      result: 1,
                      function: hotzoneController.checkAnswerType2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        if(questionModel.answer2 != null || questionModel.answer2 != '')
          Padding(
            padding: const EdgeInsets.only(bottom: NumberConstant.basePaddingMedium),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      hotzoneController.checkAnswerType2(index: index, result: 2);
                    },
                    child: _answerBoxWidget(
                      name: questionModel.answer2 ?? _Constant.answer2,
                      isChecked: questionModel.isAnswer2Input ?? false,
                      index: index,
                      result: 2,
                      function: hotzoneController.checkAnswerType2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        if(questionModel.answer3 != null || questionModel.answer3 != '')
          Padding(
            padding: const EdgeInsets.only(bottom: NumberConstant.basePaddingMedium),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      hotzoneController.checkAnswerType2(index: index, result: 3);
                    },
                    child: _answerBoxWidget(
                      name: questionModel.answer3 ?? _Constant.answer3,
                      isChecked: questionModel.isAnswer3Input ?? false,
                      index: index,
                      result: 3,
                      function: hotzoneController.checkAnswerType2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        if(questionModel.answer4 != null && questionModel.answer4 != '')
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    hotzoneController.checkAnswerType2(index: index, result: 4);
                  },
                  child: _answerBoxWidget(
                    name: questionModel.answer4 ?? _Constant.answer4,
                    isChecked: questionModel.isAnswer4Input ?? false,
                    index: index,
                    result: 1,
                    function: hotzoneController.checkAnswerType2,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _answerType3Widget(SurveyQuestionModel questionModel, int index) {
    return TextField(
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
        hintText: _Constant.hintQuestionReason,
        hintStyle: themeOwn.textStyleHint,
        contentPadding: const EdgeInsets.all(NumberConstant.basePaddingMedium),
      ),
      minLines: _Constant.minHeadline,
      maxLines: _Constant.maxHeadline,
      // maxLength: _Constant.maxCharacter,
      controller: hotzoneController.answerEditControllers[index],
      style: themeOwn.textStyleDefault,
    );
  }

  Widget _answerBoxWidget({
    required String name,
    required bool isChecked,
    required int index,
    required int result,
    required Function function,
  }) {
    return Container(
      padding: const EdgeInsets.all(NumberConstant.basePaddingLarge),
      decoration: BoxDecoration(
        border: Border.all(
          color: isChecked ? themeOwn.mainColor : themeOwn.dividerColor,
        ),
        borderRadius: BorderRadius.circular(NumberConstant.baseRadiusBorderSmall),
      ),
      child: Row(
        children: [
          Text(name,
            style: themeOwn.textStyleListTitle!.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: NumberConstant.baseSizeIconSmall,
            width: NumberConstant.baseSizeIconSmall,
            child: Checkbox(
              side: BorderSide(width: 1, color: themeOwn.dividerColor),
              activeColor: themeOwn.mainColor,
              value: isChecked,
              shape: const CircleBorder(),
              onChanged: (bool? value) {
                function(index: index, result: result);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomButton(BuildContext context) {
    return RawMaterialButton(
      fillColor: AppColor.mainColor,
      onPressed: () async {
        await hotzoneController.saveStep(
            isUpdate: outletDetailController.steps[1].status == 1,
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
