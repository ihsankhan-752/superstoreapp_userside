import 'package:flutter/material.dart';
import 'package:superstore_app/custom_widgets/buttons.dart';
import 'package:superstore_app/utils/styles/colors.dart';
import 'package:superstore_app/utils/styles/text_styles.dart';
import '../custom_bottom_navigation_bar.dart';

class WelcomeBackScreen extends StatelessWidget {
  const WelcomeBackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios_new)),
            Spacer(),
            Text("Welcome",
                style: AppTextStyles().subHeading.copyWith(
                    color: ColorPallet.Pink_COLOR,
                    fontSize: 16,
                    fontWeight: FontWeight.w400))
          ],
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Superstore",
              style:
                  AppTextStyles().H1.copyWith(color: ColorPallet.PRIMARY_BLACK),
            ),
            Text(
              "Fashion",
              style: AppTextStyles()
                  .subHeading
                  .copyWith(color: ColorPallet.PRIMARY_BLACK),
            ),
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 40,
              backgroundColor: ColorPallet.GREY_COLOR,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Welcome Back",
              style: AppTextStyles()
                  .H1
                  .copyWith(color: ColorPallet.PRIMARY_BLACK, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Jameson Dunn",
              style: AppTextStyles()
                  .subHeading
                  .copyWith(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 50,
            ),
            PrimaryButton(
              title: 'CONTINUE AS JAMESON',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return CustomBottomNavigation();
                }));
              },
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorPallet.GREY_COLOR),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text(
                    'SWITCH ACCOUNT',
                    style: AppTextStyles()
                        .subHeading
                        .copyWith(color: ColorPallet.PRIMARY_BLACK),
                  ))),
            )
          ],
        ),
      ),
    );
  }
}
