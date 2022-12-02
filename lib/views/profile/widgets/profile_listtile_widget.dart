import 'package:flutter/material.dart';

class ProfileListTileWidget extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final IconData? icon;
  const ProfileListTileWidget({Key? key, this.title, this.onPressed, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed ?? () {},
      leading: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(05),
          color: Colors.red.withOpacity(0.5),
        ),
        child: Center(
          child: Icon(icon!, size: 15),
        ),
      ),
      title: Text(title!),
      trailing: Icon(Icons.arrow_forward_ios_outlined, size: 15),
    );
  }
}
