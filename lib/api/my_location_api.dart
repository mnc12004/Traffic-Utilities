//import 'package:flutter/services.dart';
//import 'package:location/location.dart';
//import 'package:trafficutilities/models/location_data.dart';
//
//class MyLocationApi {
//  Location _location = Location();
//  String error;
//
//  static MyLocationApi _instance;
//  static MyLocationApi getInstance() => _instance ??= MyLocationApi();
//
//  Future<MyLocationData> getLocation() async {
//    Map<String, double> location;
//
//    try {
//      location = await _location.getLocation();
//      error = null;
//    } on PlatformException catch (e) {
//      if (e.code == 'PERMISSION_DENIED') {
//        error = 'Permission Denied';
//      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASKED') {
//        error =
//            'Permission Denied - please ask user to enable in the app settings.';
//      }
//      location = null;
//    }
//    return MyLocationData.locationItems(location);
//  }
//}
