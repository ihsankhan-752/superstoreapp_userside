import 'package:flutter/material.dart';
import 'package:superstore_app/services/auth_services.dart';
import 'package:superstore_app/utils/functions/functions.dart';
import 'package:superstore_app/utils/styles/colors.dart';
import 'package:superstore_app/utils/styles/text_field_decoration.dart';
import 'package:superstore_app/utils/styles/text_styles.dart';
import 'package:superstore_app/views/auth/signup_screen.dart';

import '../../custom_widgets/buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 150),
                  Center(
                    child: Text(
                      "Customer Login",
                      style: AppTextStyles.MAIN_SPLASH_HEADING.copyWith(color: ColorPallet.PRIMARY_BLACK),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    onSaved: (v) {
                      setState(() {
                        email = v!;
                      });
                    },
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Email must be filled";
                      } else {
                        return null;
                      }
                    },
                    decoration: inputDecoration.copyWith(labelText: "Email"),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    onSaved: (v) {
                      setState(() {
                        password = v!;
                      });
                    },
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Password Must Be Filled";
                      } else {
                        return null;
                      }
                    },
                    decoration: inputDecoration.copyWith(labelText: "Password"),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forget Password ?",
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorPallet.PRIMARY_BLACK,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                  PrimaryButton(
                    onTap: () {
                      if (_key.currentState!.validate()) {
                        _key.currentState!.save();
                        AuthServices.signIn(context, email, password);
                      }
                    },
                    title: "Sign In",
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () => navigateToPageWithPush(context, SignUpScreen()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an Account? ",
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorPallet.PRIMARY_BLACK,
                          ),
                        ),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.purple,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
