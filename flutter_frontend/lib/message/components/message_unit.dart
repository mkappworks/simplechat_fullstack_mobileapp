import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_frontend/viewmodel/message_view_model.dart';

class MessageUnit extends StatelessWidget {
  final MessageViewModel messageViewModel;
  final bool isMy;

  MessageUnit({required this.messageViewModel, required this.isMy});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          messageViewModel.isMy ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
        child: Column(
          crossAxisAlignment: messageViewModel.isMy
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: messageViewModel.isMy
                      ? Color(0xFF1289FD)
                      : Color(0xFFE5E4EA)),
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              child: Text(messageViewModel.content,
                  style: TextStyle(
                      color:
                          messageViewModel.isMy ? Colors.white : Colors.black)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12, bottom: 4),
              child: Text(
                DateFormat('HH:mm')
                    .format(DateTime.parse(messageViewModel.createdAt)),
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
