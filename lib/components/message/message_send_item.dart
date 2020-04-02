import 'package:flutter/material.dart';
import 'package:makeriends/config/config.dart';
import 'package:makeriends/model/message.dart';

class MessageSendItem extends StatelessWidget {
  final Message message;

  MessageSendItem({Key key, this.message, this.onPressed}) : super(key: key);
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onPressed,
      child: new Container(
        alignment: Alignment(1.0, 0.0),
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.only(
            left: 18.0, top: 10.0, right: 18.0, bottom: 10.0),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: LimitedBox(
                    maxWidth: MediaQuery.of(context).size.width * 0.6,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Config.GLOBAL_COLOR,
                      ),
                      child: Text(
                        message.message,
                        style: new TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(
                  message.head),
              radius: 25,
            ),
          ],
        ),
      ),
    );
  }
}
