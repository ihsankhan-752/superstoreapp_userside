import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:superstore_app/controllers/cart_controller.dart';
import 'package:superstore_app/controllers/wishlist_controller.dart';
import 'package:superstore_app/services/notification_services.dart';
import 'package:superstore_app/utils/services/stripe_services.dart';
import 'package:superstore_app/views/custom_bottom_navigation_bar.dart';
import 'package:superstore_app/views/splash/main_splash_screen.dart';
import 'package:superstore_app/views/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationServices().init();
  Stripe.publishableKey = stripePublishableKey;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartController()),
        ChangeNotifierProvider(create: (_) => WishListController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // initialRoute: '/main_splash',
        routes: {
          MainSplashScreen.routeName: (_) => MainSplashScreen(),
          SplashScreen.routeName: (_) => SplashScreen(),
          CustomBottomNavigation.routeName: (_) => CustomBottomNavigation(),
        },
        home: MainSplashScreen(),
        // home: NotificationScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
