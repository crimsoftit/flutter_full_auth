import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_full_auth/utils/popups/snackbars.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CNetworkManager extends GetxController {
  static CNetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  // -- initialize the network manager and set up a stream to continually check the connection status --
  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  // -- check internet connection status --
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  // -- update the connection status and show relevant popup --
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;
    if (result == ConnectivityResult.none) {
      CPopupSnackBar.customToast(
        message: 'please check your internet connection...',
      );
      // CPopupSnackBar.warningSnackBar(
      //   title: 'check your internet connection',
      // );
    }
  }

  // -- dispose or close the active connectivity stream
  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}
