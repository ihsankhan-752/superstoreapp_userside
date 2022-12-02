import 'package:flutter/cupertino.dart';

Future<void> customAlertDialogBox({
  BuildContext? context,
  String? title,
  String? content,
  VoidCallback? plusBtnClicked,
  VoidCallback? negativeBtnClicked,
}) {
  return showCupertinoModalPopup<void>(
    context: context!,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title!),
      content: Text(content!),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('No'),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: plusBtnClicked ?? () {},
          child: Text('Yes'),
        ),
      ],
    ),
  );
}
