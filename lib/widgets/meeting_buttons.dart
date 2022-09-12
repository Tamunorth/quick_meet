import 'package:flutter/material.dart';
import 'package:quick_meet/utils/colors.dart';

class MeetingButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String text;
  const MeetingButton(
      {Key? key,
      required this.onTap,
      this.icon = Icons.add,
      this.text = 'add '})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 70,
        child: Column(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Pallets.buttonColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.06),
                        offset: Offset(0, 4))
                  ]),
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
