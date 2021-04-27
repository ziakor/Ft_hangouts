import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  //le plus recent -> index 0;

  Message({Key key}) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  List<Map> messageList = [
    {"id": 0, "message": "je suis une bite 1", "timestamp": 1, "fromMe": true},
    {"id": 1, "message": "non cest moi", "timestamp": 2, "fromMe": false},
    {"id": 1, "message": "non cest moi", "timestamp": 2, "fromMe": false},
    {"id": 1, "message": "non cest moi", "timestamp": 2, "fromMe": true},
    {"id": 1, "message": "non cest moi", "timestamp": 2, "fromMe": false},
    {"id": 1, "message": "non cest moi", "timestamp": 2, "fromMe": false},
    {"id": 1, "message": "non cest moi", "timestamp": 2, "fromMe": true},
    {"id": 1, "message": "non cest moi", "timestamp": 2, "fromMe": false},
    {"id": 1, "message": "non cest moi", "timestamp": 2, "fromMe": false},
    {"id": 1, "message": "non cest moi", "timestamp": 2, "fromMe": false},
    {"id": 1, "message": "non cest moi", "timestamp": 2, "fromMe": true},
    {"id": 1, "message": "non cest moi", "timestamp": 2, "fromMe": false},
    {"id": 1, "message": "non cest moi", "timestamp": 2, "fromMe": true},
    {"id": 1, "message": "non cest moi", "timestamp": 2, "fromMe": false},
    {"id": 1, "message": "non cest moi", "timestamp": 2, "fromMe": false},
    {"id": 1, "message": "non cest moi", "timestamp": 2, "fromMe": true},
    {"id": 1, "message": "non cest moi", "timestamp": 2, "fromMe": false},
    {"id": 1, "message": "non cest moi", "timestamp": 2, "fromMe": false},
    {"id": 1, "message": "non cest moi", "timestamp": 2, "fromMe": true},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("nom"),
        //ajouter popumenu avec Details
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messageList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Container(
                    alignment: messageList[index]["fromMe"]
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Text(
                      messageList[index]["message"],
                    ),
                  ),
                );
              },
            ),
          ),
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "message"),
          )
        ],
      ),
    );
  }
}
