import 'package:flutter_full_auth/features/authentication/controllers/login/login_controller.dart';
import 'package:flutter_full_auth/features/authentication/screens/pswd_config/forgot_password.dart';
import 'package:flutter_full_auth/features/authentication/screens/signup/signup.dart';
import 'package:flutter_full_auth/utils/constants/colors.dart';
import 'package:flutter_full_auth/utils/constants/sizes.dart';
import 'package:flutter_full_auth/utils/constants/txt_strings.dart';
import 'package:flutter_full_auth/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(CLoginController());

    return Form(
      key: loginController.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: CSizes.spaceBtnSections),
        child: Column(
          children: [
            // -- email field --
            TextFormField(
              controller: loginController.email,
              style: const TextStyle(
                height: 0.7,
              ),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: CTexts.email,
              ),
              validator: (value) {
                return CValidator.validateEmail(value);
              },
            ),

            const SizedBox(
              height: CSizes.spaceBtnInputFields,
            ),

            // -- password field --
            Obx(
              () => TextFormField(
                controller: loginController.password,
                obscureText: loginController.hidePswdTxt.value,
                style: const TextStyle(
                  height: 0.8,
                ),
                decoration: InputDecoration(
                  labelText: CTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () {
                      loginController.hidePswdTxt.value =
                          !loginController.hidePswdTxt.value;
                    },
                    icon: Icon(
                      loginController.hidePswdTxt.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye,
                      color: loginController.hidePswdTxt.value
                          ? CColors.grey
                          : CColors.rBrown,
                    ),
                  ),
                ),
                //validator: (value) => CValidator.validatePassword(value),
              ),
            ),

            const SizedBox(
              height: CSizes.spaceBtnInputFields / 2,
            ),

            // -- remember me & forgot password checkbox and textbutton --
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // -- remember me
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: loginController.rememberMe.value,
                        onChanged: (value) {
                          loginController.rememberMe.value =
                              !loginController.rememberMe.value;
                        },
                      ),
                    ),
                    Text(
                      CTexts.rememberMe,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),

                // -- forgot password
                TextButton(
                  onPressed: () {
                    Get.to(() => const ForgotPasswordScreen());
                  },
                  child: Text(
                    CTexts.forgotPassword,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: CSizes.spaceBtnInputFields / 2,
            ),

            // -- sign in button --
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  loginController.emailAndPasswdSignIn();
                },
                child: Text(
                  CTexts.signIn.toUpperCase(),
                  style: Theme.of(context).textTheme.labelMedium?.apply(
                        color: CColors.white,
                      ),
                ),
              ),
            ),

            const SizedBox(
              height: CSizes.spaceBtnItems / 2,
            ),

            // -- create account button --
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Get.to(() => const SignupScreen());
                },
                child: Text(
                  CTexts.createAccount.toUpperCase(),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
