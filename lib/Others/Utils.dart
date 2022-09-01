import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'CommonUtils.dart';
class Utils {
  Future<void> call(mobile) async {

    final Uri launchUri=Uri(
      scheme: 'tel',
      path: mobile,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $mobile';
    }
  }

  Future<void> getDeviceINFO() async {
    var deviceData = <String, dynamic>{};
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        CommonUtils.deviceType="2";
        deviceData =
            _readAndroidBuildData(await deviceInfoPlugin.androidInfo);

        CommonUtils.osVersion='${deviceData['version.sdkInt']}';
        CommonUtils.deviceModel='${deviceData['brand']}${deviceData['device']}';

      }
      else if (Platform.isIOS) {
        CommonUtils.deviceType="1";
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      //  deviceData['version.systemVersion'];
        CommonUtils.osVersion= "15.5";
        CommonUtils.deviceModel=deviceData['model'];
      }
      else {

      }


    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  String getTimeStamp(){
    DateTime _now = DateTime.now();
    CommonUtils.timeStamp='${_now.hour}:${_now.minute}:${_now.second}.${_now.millisecond}';
    return CommonUtils.timeStamp.toString();
  }

  String getTimeZone(){
    DateTime now = DateTime.now();
    var timezone = now.timeZoneName;
    var offset = now.timeZoneOffset;
    CommonUtils.timeZone='timeZone: ${timezone}:${offset}';
    return CommonUtils.timeZone.toString();
  }

}