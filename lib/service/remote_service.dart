import 'package:http/http.dart' as http;
export './home_service.dart';
export './outlet_service.dart';

class RemoteServices {
  static const timeout = 30000;
  static var client = http.Client();
  static var responseTimeout = http.Response('Timeout', 408);
  static var host = 'https://mdlz-cooler.com';

}
