import 'package:flutter_full_auth/features/authentication/controllers/onboarding/ob_controller.dart';
import 'package:flutter_full_auth/utils/constants/colors.dart';
import 'package:flutter_full_auth/utils/constants/sizes.dart';
import 'package:flutter_full_auth/utils/device/device_utilities.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingDotNavWidget extends StatelessWidget {
  const OnboardingDotNavWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final obController = OnboardingController.instance;

    return Positioned(
      bottom: CDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: CSizes.defaultSpace,
      child: SmoothPageIndicator(
        count: 3,
        controller: obController.pageController,
        onDotClicked: obController.dotNavigationClick,
        effect: const ExpandingDotsEffect(
          activeDotColor: CColors.rBrown,
          dotHeight: 6,
        ),
      ),
    );
  }
}
