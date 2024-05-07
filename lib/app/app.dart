import 'package:cooler_mdlz/app/utlis/utils.dart';
import 'package:cooler_mdlz/view/outlet/outlet_detail_page.dart';
import 'package:flutter/material.dart';

import '../common/common.dart';
import '../controller/home_controller.dart';
import '../controller/hotzone_controller.dart';
import '../controller/maintenance_controller.dart';
import '../controller/outlet_detail_controller.dart';
import '../controller/scan_qrcode_controller.dart';
import '../controller/stock_controller.dart';
import '../view/google_map_page.dart';
import '../view/home/home_page.dart';
import '../view/hotzone/hotzone_page.dart';
import '../view/maintenance/maintenance_page.dart';
import '../view/outlet/outlet_detail_view_page.dart';
import '../view/qrcode/qrcode_view_screen.dart';
import '../view/qrcode/scan_qrcode_page.dart';
import '../view/stock_count/stock_page.dart';
import '../view/splash/welcome_page.dart';
import '../widgets/image_full_screen_widget.dart';

class MobileApp extends StatelessWidget {
  MobileApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Todo: custom theme light/dark
    return GetMaterialApp(
      title: appName,
      theme: AppTheme.light(context),
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.route,
      initialBinding: BindingsBuilder.put(() => HomeController()),
      getPages: pages,
    );
  }

  final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage(
      name: WelcomeScreen.route,
      page: () => const WelcomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(() => HomeController());
      }),
    ),
    GetPage(
      name: HomePage.route,
      page: () => const HomePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(() => HomeController());
      }),
    ),
    GetPage(
      name: OutletDetailPage.route,
      page: () => const OutletDetailPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OutletDetailController>(() => OutletDetailController());
      }),
    ),
    GetPage(
      name: OutletDetailViewPage.route,
      page: () => const OutletDetailViewPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OutletDetailController>(() => OutletDetailController());
      }),
    ),
    GetPage(
      name: ScanQrcodePage.route,
      page: () => const ScanQrcodePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ScanQrcodeController>(() => ScanQrcodeController());
        Get.lazyPut<OutletDetailController>(() => OutletDetailController());
      }),
    ),
    GetPage(
      name: HotzonePage.route,
      page: () => const HotzonePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HotZoneController>(() => HotZoneController());
        Get.lazyPut<OutletDetailController>(() => OutletDetailController());
      }),
    ),
    GetPage(
      name: StockPage.route,
      page: () => const StockPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<StockController>(() => StockController());
        Get.lazyPut<OutletDetailController>(() => OutletDetailController());
      }),
    ),
    GetPage(
      name: MaintenancePage.route,
      page: () => const MaintenancePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MaintenanceController>(() => MaintenanceController());
        Get.lazyPut<OutletDetailController>(() => OutletDetailController());
      }),
    ),
    GetPage(
      name: QrcodeViewScreen.route,
      page: () => const QrcodeViewScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ScanQrcodeController>(() => ScanQrcodeController());
        Get.lazyPut<OutletDetailController>(() => OutletDetailController());
      }),
    ),
    GetPage(
      name: GoogleMapPage.route,
      page: () => const GoogleMapPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OutletDetailController>(() => OutletDetailController());
      }),
    ),
    GetPage(
      name: ImageFullScreenWidget.route,
      page: () => ImageFullScreenWidget(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OutletDetailController>(() => OutletDetailController());
      }),
    ),
  ];
}
