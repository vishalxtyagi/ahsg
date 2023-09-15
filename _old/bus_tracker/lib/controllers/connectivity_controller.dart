import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityController {
  Future<bool> checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<String> getConnectionType() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult.toString();
  }
}