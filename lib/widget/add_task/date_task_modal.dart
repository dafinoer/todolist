import 'package:flutter/material.dart';

class DateTaskModal extends StatelessWidget {
  final now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Today, 19: - 21:00',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        RotatedBox(
          quarterTurns: 1,
          child: IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: () async {
                final date = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: DateTime(2019),
                    lastDate: DateTime(now.year + 1));
              }),
        ),
      ],
    );
  }
}
