import 'package:flutter_full_auth/data/repos/user/user_repo.dart';
import 'package:flutter_full_auth/features/personalization/controllers/user_controller.dart';
import 'package:flutter_full_auth/features/personalization/screens/profile/profile.dart';
import 'package:flutter_full_auth/utils/constants/img_strings.dart';
import 'package:flutter_full_auth/utils/helpers/network_manager.dart';
import 'package:flutter_full_auth/utils/popups/full_screen_loader.dart';
import 'package:flutter_full_auth/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CUpdateNameController extends GetxController {
  static CUpdateNameController get instance => Get.find();

  // -- variables --
  final fullName = TextEditingController();
  final userController = CUserController.instance;
  final userRepo = Get.put(CUserRepo());

  GlobalKey<FormState> editNameFormKey = GlobalKey<FormState>();

  // -- initialize user data when home screen loads --
  @override
  void onInit() {
    initializeName();
    super.onInit();
  }

  // -- fetch user record --
  Future<void> initializeName() async {
    fullName.text = userController.user.value.fullName;
  }

  // -- update user details --
  Future<void> updateName() async {
    try {
      // -- start loader
      CFullScreenLoader.openLoadingDialog(
        'we\'re updating your info...',
        CImages.docerAnimation,
      );

      // -- check internet connectivity
      final isConnected = await CNetworkManager.instance.isConnected();
      if (!isConnected) {
        // stop loader
        CFullScreenLoader.stopLoading();
        return;
      }

      // -- form validation
      if (!editNameFormKey.currentState!.validate()) {
        CFullScreenLoader.stopLoading();
        return;
      }

      // -- update user's fullname in the firebase firestore
      Map<String, dynamic> name = {'FullName': fullName.text.trim()};
      await userRepo.updateSpecificUser(name);

      // -- update the Rx User values
      userController.user.value.fullName = fullName.text.trim();

      // -- stop loader
      CFullScreenLoader.stopLoading();

      // -- show success message
      CPopupSnackBar.successSnackBar(
          title: 'ngrats!', message: 'your name was updated successfully.');

      // -- go back to profile screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      CFullScreenLoader.stopLoading();
      CPopupSnackBar.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
    }
  }
}
