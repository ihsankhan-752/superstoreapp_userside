import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final IconData? icon;
  final VoidCallback? onPressed;
  const CustomListTile(
      {Key? key, this.title, this.icon, this.onPressed, this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onPressed ?? () {},
          leading: Icon(icon),
          title: Text(title!),
          subtitle: Text(subTitle!),
        ),
        Divider(
          color: Colors.purple,
          endIndent: 30,
          indent: 30,
        )
      ],
    );
  }
}
