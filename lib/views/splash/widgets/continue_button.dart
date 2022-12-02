import 'package:flutter/material.dart';
import 'package:superstore_app/utils/functions/functions.dart';
import 'package:superstore_app/views/auth/sign_in_screen.dart';
import 'package:superstore_app/utils/styles/colors.dart';
import 'package:superstore_app/utils/styles/text_styles.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
        color: ColorPallet.DARK_GREY_COLOR,
      ),
      child: InkWell(
        onTap: () {
          navigateToPageWithPush(context, LoginScreen());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'CONTINUE',
              style: AppTextStyles().H2.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 120,
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
