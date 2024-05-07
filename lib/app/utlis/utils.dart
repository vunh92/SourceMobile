import 'package:cooler_mdlz/common/common.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

export 'package:get/get.dart';
export '../themes/app_theme.dart';
export '../colors/app_color.dart';
export '../../widgets/snackbar_helper.dart';
export '../../widgets/dialogs/wrong_location_dialog.dart';
export '../../widgets/dialogs/cannot_scan_qrcode_dialog.dart';
export '../../widgets/dialogs/no_internet_dialog.dart';
export '../../widgets/dialogs/view_outlet_detail_dialog.dart';
export '../../widgets/dialogs/custom_dialog.dart';
export './sqlite_db.dart';
export './sqlite_helper.dart';
export './shared_preferences_util.dart';

class Utils {
  static Future<void> openMap({required double latitude, required double longitude}) async {
    var googleUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
    if (await canLaunchUrl(googleUrl) != null) {
        await launchUrl(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  static String getAddress({
    String location1 = '',
    String location2 = '',
    String location3 = '',
    String location4 = '',
  }) {
    String address = '';
    address += location1.isEmpty ? '' : '$location1, ';
    address += location2.isEmpty ? '' : '$location2, ';
    address += location3.isEmpty ? '' : '$location3, ';
    address += location4.isEmpty ? '' : '$location4, ';
    return address;
  }

  static double getDistance({
    double latStart = 0,
    double longStart = 0,
    double latEnd = 0,
    double longEnd = 0,
  }) => Geolocator.distanceBetween(latStart, longStart, latEnd, longEnd).toFixed(1);

  static double exchangeDistance({
    required double distance
  }) => distance >= 1000 ?  (distance/1000).toFixed(2) : distance;
}
