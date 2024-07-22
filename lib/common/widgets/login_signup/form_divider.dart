import 'package:flutter_full_auth/utils/constants/colors.dart';
import 'package:flutter_full_auth/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CFormDivider extends StatelessWidget {
  const CFormDivider({
    super.key,
    required this.dividerText,
  });

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: isDarkTheme ? CColors.grey : CColors.darkGrey,
            thickness: 0.5,
            indent: 60,
            endIndent: 5,
          ),
        ),
        Text(
          dividerText,
          style: Theme.of(context).textTheme.labelMedium?.apply(
                color: CColors.darkGrey,
                fontSizeFactor: 0.8,
              ),
        ),
        Flexible(
          child: Divider(
            color: isDarkTheme ? CColors.darkGrey : CColors.grey,
            thickness: 0.5,
            indent: 5,
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}
