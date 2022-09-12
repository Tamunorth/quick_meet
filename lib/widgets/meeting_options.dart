import 'package:flutter/material.dart';
import 'package:quick_meet/utils/colors.dart';

class MeetingOptions extends StatelessWidget {
  final String text;
  final bool isMuted;
  final Function(bool) onChanged;

  const MeetingOptions(
      {Key? key,
      required this.text,
      required this.isMuted,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        color: Pallets.secondaryBackgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Switch.adaptive(value: isMuted, onChanged: onChanged),
          ],
        ));
  }
}
