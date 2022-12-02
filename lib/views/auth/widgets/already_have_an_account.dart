import 'package:flutter/material.dart';

import 'package:superstore_app/utils/styles/app_text.dart';
import 'package:superstore_app/utils/styles/colors.dart';

class AlreadyHaveAnAccountWidget extends StatelessWidget {
  const AlreadyHaveAnAccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          AppText.ALREADY_ACC,
          style: TextStyle(
            color: ColorPallet.PRIMARY_BLACK,
            fontStyle: FontStyle.italic,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          AppText.SIGN_IN,
          style: TextStyle(
            color: Colors.purple,
            fontStyle: FontStyle.italic,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
