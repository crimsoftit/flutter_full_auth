import 'package:flutter_full_auth/common/widgets/login_signup/form_divider.dart';
import 'package:flutter_full_auth/common/widgets/login_signup/social_buttons.dart';
import 'package:flutter_full_auth/features/authentication/screens/login/login.dart';
import 'package:flutter_full_auth/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:flutter_full_auth/utils/constants/colors.dart';
import 'package:flutter_full_auth/utils/constants/sizes.dart';
import 'package:flutter_full_auth/utils/constants/txt_strings.dart';
import 'package:flutter_full_auth/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -- title --
              Text(
                CTexts.signUpTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: CSizes.spaceBtnSections / 4,
              ),

              // -- divider --
              // const CFormDivider(
              //   dividerText: 'already have an account?',
              // ),

              TextButton(
                onPressed: () {
                  Get.offAll(const LoginScreen());
                },
                child: Text(
                  'or click here to sign in',
                  style: Theme.of(context).textTheme.bodySmall!.apply(
                        color: isDarkTheme ? CColors.grey : CColors.rBrown,
                      ),
                  textAlign: TextAlign.left,
                ),
              ),

              const SizedBox(
                height: CSizes.spaceBtnSections / 4,
              ),

              // -- signup form --
              const RSignupForm(),

              // -- divider --
              CFormDivider(
                dividerText: CTexts.orSignInWith.capitalize!,
              ),

              const SizedBox(
                height: CSizes.spaceBtnSections,
              ),

              // -- footer --
              const CSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
