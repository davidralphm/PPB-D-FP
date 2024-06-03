import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:platform_device_id/platform_device_id.dart';

mixin UserService on Model {
  String? _uid = "";
  String? get uid => _uid;

  String? _nama = "";
  String? get nama => _nama;

  String? _email = "";
  String? get email => _email;

  // Future getDIDfcmToken(BuildContext context) async {
  //   _deviceId = await PlatformDeviceId.getDeviceId;
  //   print("Device ID: $_deviceId");

  //   notifyListeners();
  //   //

  //   await saveToSqlite({"deviceId": _deviceId});
  //   notifyListeners();
  // }

  void setLoggedData(String uidData, String emailData, String namaData) {
    _uid = uidData;
    _email = emailData;
    _nama = namaData;
    notifyListeners();
  }

  Future saveToSqlite(String? nama, String? email, String? uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Future.wait([
      prefs.setString('nama', nama ?? ""),
      prefs.setString('email', email ?? ""),
      prefs.setString('uid', uid ?? ""),
    ]);
  }

  Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<Map> checkUid() async {
    var _data;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // load variable

    _nama = (prefs.getString('nama'));
    _email = (prefs.getString('email'));
    _uid = (prefs.getString('uid'));

    _data = {
      'nama': _nama,
      'email': _email,
      'uid': _uid,
    };

    notifyListeners();

    print(_data['nama']);
    print(_data['uid']);
    print(_data['email']);

    return _data;
  }

  void clearUser() {
    _uid = null;
    _nama = null;
    _email = null;
    notifyListeners();
  }
}
