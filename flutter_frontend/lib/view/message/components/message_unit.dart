import 'package:flutter/material.dart';
import 'package:flutter_frontend/utilities/constants.dart';
import 'package:intl/intl.dart';

import 'package:flutter_frontend/model/message.dart';

class MessageUnit extends StatelessWidget {
  final Message message;
  final bool isCurrentSearch;

  MessageUnit({required this.message, required this.isCurrentSearch});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMy ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
        child: Column(
          crossAxisAlignment:
              message.isMy ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: message.isMy
                      ? kColorGrey.withOpacity(0.5)
                      : kColorLightBlue),
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              //This shoukd be show color kColorYellow.withOpacity(0.6) when search message is selected
              child: Container(
                color: isCurrentSearch
                    ? kColorYellow.withOpacity(0.6)
                    : Colors.transparent,
                child: Text(message.message,
                    style: TextStyle(
                        color: message.isMy ? kColorBlack : kColorWhite)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12, bottom: 4),
              child: Text(
                DateFormat('HH:mm').format(message.createdAt),
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
