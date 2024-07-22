import 'package:flutter_full_auth/utils/constants/colors.dart';
import 'package:flutter_full_auth/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// -- a widget for displaying an animated loading indicator with optional text & action button --
class CAnimationLoaderWidget extends StatelessWidget {
  /// === parameters ===
  ///   - text: text to be displayed below the animation --
  ///   - animation: path to the lottie animation file --
  ///   - showActionBtn: toggles displaying an action button below the text --
  ///   - actionText: text displayed on the action button --
  ///   - onActionPressed: callback function executed onPress of the action button --
  ///
  /// === default constructor for the CAnimationLoaderWidget

  const CAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showActionBtn = false,
    this.actionBtnText,
    this.onActionBtnPressed,
  });

  final bool showActionBtn;
  final String text, animation;
  final String? actionBtnText;
  final VoidCallback? onActionBtnPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            animation,
            width: MediaQuery.of(context).size.width * 0.8,
          ),
          const SizedBox(
            height: CSizes.defaultSpace,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: CSizes.defaultSpace,
          ),
          showActionBtn
              ? SizedBox(
                  width: 250.0,
                  child: OutlinedButton(
                    onPressed: onActionBtnPressed,
                    style: OutlinedButton.styleFrom(
                      //backgroundColor: CColors.rBrown,
                      backgroundColor: CColors.dark,
                    ),
                    child: Text(
                      actionBtnText!,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: CColors.light,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
