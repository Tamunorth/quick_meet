import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum SnackType { error, success, normal }

class QuickMeet {
  SnackType type = SnackType.success;

  static showSnackBar(
    BuildContext context,
    String text, {
    SnackType? type,
  }) {
    final Color bgColor;

    if (type == null) {
      type = SnackType.success;
    }
    switch (type) {
      case SnackType.error:
        bgColor = Colors.red;
        break;
      case SnackType.success:
        bgColor = Colors.green;
        break;
      case SnackType.normal:
        bgColor = Colors.black;
        break;
    }

    ScaffoldMessenger.of(context).clearSnackBars();

    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: bgColor,
      margin: EdgeInsets.all(20.0),
      elevation: 5,
    ));
  }

  static void showLoading(BuildContext context, GlobalKey key,
      [String message = 'Loading...']) async {
    final dialog = Dialog(
      key: key,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      child: const Center(child: CircularProgressIndicator()),
    );

    await showDialog(
      context: context,
      barrierColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (BuildContext context) => dialog,
      barrierDismissible: false,
    );
  }

  static void hideLoading(GlobalKey key) {
    if (key.currentContext != null) {
      Navigator.of(key.currentContext!, rootNavigator: true).pop();
    } else {
      Future.delayed(const Duration(milliseconds: 300)).then((value) =>
          Navigator.of(key.currentContext!, rootNavigator: true).pop());
    }
  }
}
