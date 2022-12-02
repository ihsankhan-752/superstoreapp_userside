import 'package:flutter/material.dart';
import 'package:superstore_app/utils/functions/functions.dart';
import 'package:superstore_app/views/auth/sign_in_screen.dart';
import 'package:superstore_app/views/auth/signup_screen.dart';

import 'package:superstore_app/utils/styles/colors.dart';

import 'authentication_button.dart';

class EnteringButton extends StatelessWidget {
  const EnteringButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        color: ColorPallet.GREY_COLOR.withOpacity(0.5),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25), bottomRight: Radius.circular(25)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AuthenticationButton(
              title: "Login",
              onPressed: () {
                navigateToPageWithPush(context, LoginScreen());
              }),
          AuthenticationButton(
              title: "Sign Up",
              onPressed: () {
                navigateToPageWithPush(context, SignUpScreen());
              }),
        ],
      ),
    );
  }
}
