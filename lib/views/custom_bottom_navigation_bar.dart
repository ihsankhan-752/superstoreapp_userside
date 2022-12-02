import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:superstore_app/services/notification_services.dart';
import 'package:superstore_app/views/profile/profile_screen.dart';
import 'package:superstore_app/views/store/store.dart';

import 'cart/cart_screen.dart';
import 'home/home_screen.dart';

class CustomBottomNavigation extends StatefulWidget {
  static String routeName = "/customer_home";
  const CustomBottomNavigation({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  @override
  void initState() {
    NotificationServices().getToken();
    super.initState();
  }

  int _currentIndex = 0;
  List Pages = [
    HomeScreen(),
    StoresScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Pages[_currentIndex],
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10, offset: Offset(0, 4)),
          ],
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomWidgetSelection(
              title: _currentIndex == 0 ? "Home" : "",
              icon: FontAwesomeIcons.house,
              iconColor: _currentIndex == 0 ? Colors.red : Colors.grey,
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            CustomWidgetSelection(
              title: _currentIndex == 1 ? "Stores" : "",
              iconColor: _currentIndex == 1 ? Colors.red : Colors.grey,
              icon: Icons.store,
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            CustomWidgetSelection(
              title: _currentIndex == 2 ? "Cart" : "",
              icon: FontAwesomeIcons.cartShopping,
              iconColor: _currentIndex == 2 ? Colors.red : Colors.grey,
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
            CustomWidgetSelection(
              title: _currentIndex == 3 ? "Account" : "",
              iconColor: _currentIndex == 3 ? Colors.red : Colors.grey,
              icon: FontAwesomeIcons.person,
              onPressed: () {
                setState(() {
                  _currentIndex = 3;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomWidgetSelection extends StatelessWidget {
  final Function()? onPressed;
  final IconData? icon;
  final String? title;
  final Color? iconColor;
  const CustomWidgetSelection({Key? key, this.onPressed, this.icon, this.title, this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          SizedBox(width: 04),
          Text(
            title!,
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
