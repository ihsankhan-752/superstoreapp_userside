import 'package:flutter/material.dart';
import 'package:superstore_app/utils/styles/app_images.dart';
import 'package:superstore_app/utils/styles/app_text.dart';
import 'package:superstore_app/utils/styles/colors.dart';
import 'package:superstore_app/utils/styles/text_styles.dart';

class AppProfileWidget extends StatelessWidget {
  final double? height;
  final double? width;
  const AppProfileWidget({Key? key, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          image: DecorationImage(
        colorFilter: ColorFilter.mode(
            ColorPallet.PRIMARY_BLACK.withOpacity(0.7), BlendMode.srcATop),
        image: AppImages.SPLASH_IMAGE,
        fit: BoxFit.cover,
      )),
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
    );
  }
}
