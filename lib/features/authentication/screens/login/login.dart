import 'package:flutter_full_auth/common/styles/spacing_styles.dart';
import 'package:flutter_full_auth/common/widgets/login_signup/form_divider.dart';
import 'package:flutter_full_auth/common/widgets/login_signup/social_buttons.dart';
import 'package:flutter_full_auth/features/authentication/screens/login/widgets/login_form.dart';
import 'package:flutter_full_auth/features/authentication/screens/login/widgets/login_header.dart';
import 'package:flutter_full_auth/utils/constants/sizes.dart';
import 'package:flutter_full_auth/utils/constants/txt_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: CSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -- logo, title, and subtitle --
              const LoginHeader(),

              // -- login form --
              const LoginForm(),

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
