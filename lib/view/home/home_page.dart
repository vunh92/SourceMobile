import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/utlis/utils.dart';
import '../../common/common.dart';
import '../../controller/home_controller.dart';
import '../../model/entities.dart';
import 'all_outlet_screen.dart';
import 'checked_screen.dart';
import 'today_screen.dart';
import 'un_checked_screen.dart';

class _Constant {
  static const radiusAvatar = 20.0;
  static const minHeadline = 1;
  static const maxCharacter = 200;
  static const day = 'ngày';
  static const month = 'tháng';
  static const year = 'năm';
  static const tabs = 4;
  static const nameAllTab = 'Tất cả';
  static const nameTodayTab = 'Hôm nay';
  static const nameCheckedTab = 'Đã viếng thăm';
  static const nameUnCheckedTab = 'Chưa viếng thăm';
  static const nameWelcome = 'Xin chào';
  static const nameUsername = 'Username';
  static const nameEmail = 'Email';
  static const nameImei = 'IMEI';
  static const nameVersion = 'Phiên bản';
  static const support = 'Hỗ trợ';
  static const supportPhone = '0869333537';
  static const nameInputHint = 'Tìm kiếm';
  static const period = 7;
  static TextStyle styleAvatar = const TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
  );
}

class HomePage extends StatefulWidget {
  static const route = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  late OwnThemeFields themeOwn;
  final FocusNode searchFocusNode = FocusNode();
  final HomeController homeController = Get.find<HomeController>();
  late DeviceModel deviceModel;
  DateTime startDate = DateTime.now().subtract(const Duration(days: _Constant.period));
  DateTime lastDate = DateTime.now().add(const Duration(days: _Constant.period));
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    deviceModel = homeController.deviceModel.value;
    _tabController = TabController(length: _Constant.tabs, vsync: this, initialIndex: 1);
    _tabController.addListener(_setTabIndex);
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   _showImeiDialog();
    // });
  }

  void _setTabIndex() {
    homeController.selectTab(_tabController.index);
  }

  Future<void> _showImeiDialog() async {
    await Get.dialog(CustomDialog.showOkMessage(
      context: context,
      title: 'Device ID',
      message: deviceModel.imei ?? '',
    ));
  }

  String _getCurrentDate() {
    final weekday = WeekdayEnum.values.byName(homeController.selectedDate.value.toStringWithFormat(format: 'EEEE').toString().toUpperCase()).name();
    final day = homeController.selectedDate.value.toStringWithFormat(format: 'dd');
    final month = homeController.selectedDate.value.toStringWithFormat(format: 'MM');
    final year = homeController.selectedDate.value.toStringWithFormat(format: 'yyyy');
    return "$weekday, ${_Constant.day} $day/$month/$year";
  }

  Future<void> _selectDate(BuildContext context, DateTime selectedDate) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: startDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: themeOwn.mainColor, // header background color
              onPrimary: Colors.white, // header text color
              // onSurface: Colors.green, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: themeOwn.mainColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if(picked != null) {
      homeController.selectDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    themeOwn = Theme.of(context).own();
    return GestureDetector(
      onTap: () {
        homeController.myFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: _appBar(),
        drawer: GetBuilder<HomeController>(
            init: homeController,
            builder: (controller) {
              return  _drawerWidget();
            }
        ),
        body: GetBuilder<HomeController>(
          init: homeController,
          builder: (controller) {
            return _buildBody(context);
          }
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text(appName),
      titleSpacing: 0,
      actions: [
        InkWell(
          onTap: () {
            _selectDate(context, homeController.selectedDate.value);
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: NumberConstant.basePaddingMedium),
              child: Obx(() => Text(_getCurrentDate())),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: themeOwn.backgroundColor,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(NumberConstant.basePaddingMedium),
                color: themeOwn.mainColor,
                child: _searchWidget(),
              ),
              Container(
                color: themeOwn.mainColor,
                child: _tabBarTitle(),
              ),
              Expanded(
                child: _tabBarWidget(homeController),
              ),
            ],
          ),
        ),
        if(homeController.isPageLoading.value)
          Container(
            color: themeOwn.dividerColor.withOpacity(0.5),
            child: Center(child: CircularProgressIndicator(
              color: themeOwn.mainColor,
            )),
          )
      ],
    );
  }

  Widget _drawerWidget() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    assetImagePath + logoHeader,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(NumberConstant.basePaddingMedium),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: themeOwn.dividerColor,
                    ),
                    borderRadius: BorderRadius.circular(_Constant.radiusAvatar*2),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: _Constant.radiusAvatar,
                        backgroundColor: themeOwn.mainColor,
                        child: Center(
                          child: Text((homeController.salesModel.value.salesPersonName?.isNotEmpty ?? false)
                              ? homeController.salesModel.value.salesPersonName!.split('').first : '',
                            style: _Constant.styleAvatar,
                          ),
                        ), //Text
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: NumberConstant.basePaddingMedium),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_Constant.nameWelcome,
                              style: themeOwn.textStyleDetailDescription,
                            ),
                            Text(homeController.salesModel.value.salesPersonName ?? AppString.none,
                              style: themeOwn.textStyleDetailTitle,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(
              assetIconsPath + iconUserSvg,
              width: NumberConstant.baseSizeIconMedium,
              color: AppColor.appColorDark3,
              fit: BoxFit.fill,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_Constant.nameUsername, style: themeOwn.textStyleListDetail,),
                Text(homeController.salesModel.value.salesPersonName ?? AppString.none, style: themeOwn.textStyleListTitle,),
              ],
            ),
            minLeadingWidth: 0,
          ),
          Divider(color: themeOwn.dividerColor, height: 1,),
          ListTile(
            leading: SvgPicture.asset(
              assetIconsPath + iconEmailSvg,
              width: NumberConstant.baseSizeIconMedium,
              color: AppColor.appColorDark3,
              fit: BoxFit.fill,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_Constant.nameEmail, style: themeOwn.textStyleListDetail,),
                Text(homeController.salesModel.value.email ?? AppString.none, style: themeOwn.textStyleListTitle,),
              ],
            ),
            minLeadingWidth: 0,
          ),
          Divider(color: themeOwn.dividerColor, height: 1,),
          ListTile(
            leading: SvgPicture.asset(
              assetIconsPath + iconMobileSvg,
              width: NumberConstant.baseSizeIconMedium,
              color: AppColor.appColorDark3,
              fit: BoxFit.fill,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_Constant.nameImei, style: themeOwn.textStyleListDetail,),
                Text(homeController.deviceModel.value.imei ?? AppString.none, style: themeOwn.textStyleListTitle,),
              ],
            ),
            minLeadingWidth: 0,
          ),
          Divider(color: themeOwn.dividerColor, height: 1,),
          ListTile(
            leading: SvgPicture.asset(
              assetIconsPath + iconSquareSvg,
              width: NumberConstant.baseSizeIconMedium,
              color: AppColor.appColorDark3,
              fit: BoxFit.fill,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_Constant.nameVersion, style: themeOwn.textStyleListDetail,),
                Text('${_Constant.nameVersion} ${homeController.deviceModel.value.version ?? AppString.none}', style: themeOwn.textStyleListTitle,),
              ],
            ),
            minLeadingWidth: 0,
          ),
          Divider(color: themeOwn.dividerColor, height: 1,),
          ListTile(
            leading: SizedBox(
              width: NumberConstant.baseSizeIconMedium,
              child: Icon(Icons.phone,
                color: AppColor.appColorDark3,
                size: 20,),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_Constant.support, style: themeOwn.textStyleListDetail,),
                Text(_Constant.supportPhone, style: themeOwn.textStyleListTitle,),
              ],
            ),
            minLeadingWidth: 0,
            onTap: () async {
              _makePhoneCall(_Constant.supportPhone);
            },
          ),
          Divider(color: themeOwn.dividerColor, height: 1,),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Widget _searchWidget() {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(NumberConstant.baseRadiusBorderMedium),
          ),
          borderSide: BorderSide(width: 1, color: themeOwn.mainColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(NumberConstant.baseRadiusBorderMedium),
          ),
          borderSide: BorderSide(width: 1.5, color: themeOwn.mainColor),
        ),
        hintText: _Constant.nameInputHint,
        hintStyle: themeOwn.textStyleHint,
        prefixIcon: Icon(Icons.search, color: themeOwn.hintColor,),
        suffixIcon: homeController.searchEditController.text.isNotEmpty
            ? InkWell(
          onTap: () {
            homeController.clearSearchOutlet();
          },
          child: const Icon(Icons.clear_sharp, color: Color(0xFF979797)),
        )
            : null,
        contentPadding: const EdgeInsets.all(NumberConstant.basePaddingMedium),
      ),
      minLines: _Constant.minHeadline,
      maxLines: _Constant.minHeadline,
      // maxLength: _Constant.maxCharacter,
      controller: homeController.searchEditController,
      style: themeOwn.textStyleDefault!.copyWith(color: Colors.white),
      focusNode:  homeController.myFocusNode,
      autofocus: false,
      onChanged: (value) {
        homeController.searchOutletOnTab();
      },
    );
  }

  Widget _tabBarTitle() {
    return Obx(() => TabBar(
      controller: _tabController,
      indicatorColor: Colors.white,
      isScrollable: true,
      tabs: [
        _tapWidget(name: homeController.selectedDate.value.typeDate().compareTo(DateTime.now().typeDate()) == 0
            ? _Constant.nameAllTab : homeController.selectedDate.value.toStringWithFormat(format: "dd/MM").toString(),
          number: homeController.searchAllOutlets.isEmpty
              ? homeController.allOutlets.length
              : homeController.searchAllOutlets.length,
        ),
        _tapWidget(name: _Constant.nameTodayTab,
          number: homeController.searchOutletVisits.isEmpty
              ? homeController.todayOutlets.length
              : homeController.searchOutletVisits.length,
        ),
        _tapWidget(name: _Constant.nameUnCheckedTab,
          number: homeController.searchUncheckedOutlets.isEmpty
              ? homeController.unCheckedOutlets.length
              : homeController.searchUncheckedOutlets.length,
        ),
        _tapWidget(name: _Constant.nameCheckedTab,
          number: homeController.searchCheckedOutlets.isEmpty
              ? homeController.checkedOutlets.length
              : homeController.searchCheckedOutlets.length,
        ),
      ],
    ),);
  }

  Tab _tapWidget({required String name, required int number}) {
    return  Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name,
            style: const TextStyle(fontSize: 15),
          ),
          const SizedBox(width: NumberConstant.basePaddingSmall,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: NumberConstant.basePaddingSmall),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(NumberConstant.baseSizeIconSmall),
            ),
            child: Text(number.toString(),
              style: TextStyle(color: themeOwn.mainColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBarWidget(HomeController controller) {
    return TabBarView(
      controller: _tabController,
      children: const [
        AllOutletScreen(),
        TodayScreen(),
        UnCheckedScreen(),
        CheckedScreen(),
      ],
    );
  }
}
