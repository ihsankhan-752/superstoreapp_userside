import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:superstore_app/utils/styles/app_images.dart';
import 'package:superstore_app/utils/styles/app_text.dart';
import 'package:superstore_app/utils/styles/colors.dart';
import 'package:superstore_app/utils/styles/text_styles.dart';
import 'package:superstore_app/views/splash/widgets/customer_side_widget.dart';
import 'package:superstore_app/views/splash/widgets/entering_button.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = "/splash";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 50.0,
      fontFamily: 'Horizon',
    );
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AppImages.SPLASH_IMAGE,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  ColorPallet.PRIMARY_BLACK.withOpacity(0.6),
                  BlendMode.srcATop),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 250),
              Center(
                child: SizedBox(
                  width: 250.0,
                  child: Center(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        ColorizeAnimatedText(
                          AppText.SUPER_STORE,
                          textStyle: AppTextStyles.MAIN_SPLASH_HEADING,
                          colors: colorizeColors,
                        ),
                        ColorizeAnimatedText(
                          AppText.FASHION,
                          textStyle: colorizeTextStyle,
                          colors: colorizeColors,
                        ),
                      ],
                      isRepeatingAnimation: true,
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                ),
              ),
              CustomerSideTextWidget(),
              SizedBox(height: 25),
              EnteringButton(),
              Spacer(),
              Container(
                width: double.infinity,
                color: ColorPallet.GREY_COLOR.withOpacity(0.5),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.person, color: Colors.blue, size: 45),
                      Text(
                        "Guest",
                        style: TextStyle(
                          color: ColorPallet.PRIMARY_WHITE,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
