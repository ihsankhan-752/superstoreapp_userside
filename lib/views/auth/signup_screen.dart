import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:superstore_app/services/auth_services.dart';
import 'package:superstore_app/utils/functions/functions.dart';
import 'package:superstore_app/utils/styles/colors.dart';
import 'package:superstore_app/utils/styles/text_field_decoration.dart';
import 'package:superstore_app/utils/styles/text_styles.dart';
import 'package:superstore_app/views/auth/sign_in_screen.dart';

import '../../custom_widgets/buttons.dart';
import '../splash/splash_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> _key = GlobalKey();
  String fullName = '';
  String email = '';
  String password = '';
  String image = '';

  File? selectedImage;
  ImagePicker _picker = ImagePicker();
  Future<void> uploadImage(ImageSource source) async {
    XFile? uploadImage = await _picker.pickImage(source: source);
    if (uploadImage != null) {
      setState(() {
        selectedImage = File(uploadImage.path);
      });
    }
  }

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
                  SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Customer SignUp",
                          style: AppTextStyles.MAIN_SPLASH_HEADING
                              .copyWith(color: ColorPallet.PRIMARY_BLACK)
                              .copyWith(fontSize: 22)),
                      SizedBox(width: 20),
                      IconButton(
                          icon: Icon(Icons.home_work, size: 25, color: Colors.purple),
                          onPressed: () => navigateToPageWithPush(context, SplashScreen())),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.purple,
                        backgroundImage: selectedImage == null ? null : FileImage(selectedImage!),
                      ),
                      SizedBox(width: 40),
                      Column(
                        children: [
                          Container(
                            height: 40,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  uploadImage(ImageSource.camera);
                                },
                                icon: Icon(Icons.camera_alt, color: ColorPallet.PRIMARY_WHITE),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 40,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  uploadImage(ImageSource.gallery);
                                },
                                icon: Icon(Icons.photo, color: ColorPallet.PRIMARY_WHITE),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    onSaved: (v) {
                      setState(() {
                        fullName = v!;
                      });
                    },
                    decoration: inputDecoration.copyWith(labelText: "Full Name"),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "email Must be Filled";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (v) {
                      setState(() {
                        email = v!;
                      });
                    },
                    decoration: inputDecoration.copyWith(labelText: "Email"),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Password Must Be Filled";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (v) {
                      setState(() {
                        password = v!;
                      });
                    },
                    decoration: inputDecoration.copyWith(labelText: "Password"),
                  ),
                  SizedBox(height: 35),
                  PrimaryButton(
                    onTap: () async {
                      if (_key.currentState!.validate()) {
                        _key.currentState!.save();
                        AuthServices.signUp(
                          context: context,
                          email: email,
                          password: password,
                          fullName: fullName,
                          selectedImage: selectedImage,
                          image: image,
                        ).whenComplete(() {
                          _key.currentState!.reset();
                        });
                      }
                    },
                    // width: MediaQuery.of(context).size.width * 0.8,
                    // btnColor: ColorPallet.AMBER_COLOR,
                    title: "Sign Up",
                  ),
                  SizedBox(height: 15),
                  InkWell(
                    onTap: () => navigateToPageWithPush(context, LoginScreen()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an Account? ",
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorPallet.PRIMARY_BLACK,
                          ),
                        ),
                        Text(
                          "Sign In",
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
