import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:makeriends/api/api.dart';
import 'package:makeriends/components/message/message_receive_item.dart';
import 'package:makeriends/components/message/message_send_item.dart';
import 'package:makeriends/model/message.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Chat extends StatefulWidget{

  Chat({Key key, this.message});

  final Message message;

  @override
  _Chat createState() => _Chat();
}

class _Chat extends State<Chat> {
  TextEditingController contents = new TextEditingController();
  int userId;
  List<Message> _msgList = List();
  WebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect(Api.WEBSOCKET_URL + '/websocket/' + widget.message.name);
    channel.stream.listen((msgString) {
      Message msg = Message.fromJson(jsonDecode(msgString));
      print(msg);
      msg.type = 'receive';
      setState(() => _msgList.add(msg));
    });
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Container(
            child: Icon(Icons.chevron_left,size: 40,color: Colors.white),
            alignment: Alignment.center,
          ),
          onTap: (){
            Navigator.pop(context, true);
          },
        ),
        title: Text(
          widget.message.name,
          style: new TextStyle(fontSize: 20.0, color: Colors.white),
        )
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              child: ListView.builder(
                itemCount: _msgList.length, // 数据长度
                itemBuilder: (context, index) => _makeMessageElement(index)
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: contents,
                        autofocus: true,
                        decoration: new InputDecoration(
                          hintText: '发送一条消息',
                        ),
                      ),
                    ),
                    RaisedButton(
                      color: Colors.grey,
                      child: Text(
                        '发送',
                        style: TextStyle(color: Colors.white)
                      ),
                      onPressed: _sendMessage,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  void _sendMessage() {
    if (contents.text.isNotEmpty) {
      final Message msg = Message()
        ..name = widget.message.name
        ..head = widget.message.head
        ..message = contents.text
        ..type = 'send';

      setState(() => _msgList.add(msg));
      channel.sink.add(jsonEncode(msg.toJson()));
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  Widget _makeMessageElement(index) {
    if (index >= _msgList.length) {
      return null;
    }
    Message msg = _msgList[index];
    if (msg.type == 'send') {
      return MessageSendItem(message: msg);
    } else if (msg.type == 'receive') {
      return MessageReceiveItem(message: msg);
    }
  }
}
