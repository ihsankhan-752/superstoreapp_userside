//all those buttons which is repeated
//button names must be PrimaryButton , MainButton etc
//don't Pass required arguments
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:superstore_app/utils/styles/colors.dart';
import 'package:superstore_app/utils/styles/text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;
  const PrimaryButton({
    Key? key,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          height: 45,
          decoration: BoxDecoration(
              color: Colors.purple, borderRadius: BorderRadius.circular(10)),
          child: Center(
              child: Text(
            title!,
            style: AppTextStyles().subHeading,
          ))),
    );
  }
}

class SocialSignInButton extends StatelessWidget {
  final String? image;
  final String? title;

  const SocialSignInButton({
    Key? key,
    this.title,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          SvgPicture.asset(
            image!,
            width: 25,
            height: 25,
          ),
          SizedBox(
            width: 30,
          ),
          Text(
            title!,
            style: AppTextStyles().subHeading.copyWith(
                color: ColorPallet.PRIMARY_BLACK, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
