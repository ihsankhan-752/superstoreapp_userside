import 'package:flutter/material.dart';

import 'package:superstore_app/utils/styles/app_images.dart';
import 'package:superstore_app/utils/styles/app_text.dart';
import 'package:superstore_app/utils/styles/colors.dart';
import 'package:superstore_app/utils/styles/text_styles.dart';

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: height * .55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
        color: ColorPallet.DARK_GREY_COLOR,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
            child: Container(
              height: height * .55,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      ColorPallet.PRIMARY_BLACK.withOpacity(0.7),
                      BlendMode.srcATop),
                  image: AppImages.SPLASH_IMAGE,
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppText.SUPER_STORE,
                    style: AppTextStyles.MAIN_SPLASH_HEADING,
                  ),
                  Text(
                    AppText.FASHION,
                    style: AppTextStyles.FASHION_STYLE,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
