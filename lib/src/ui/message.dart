import 'package:flutter/material.dart';
import 'package:ft_hangout/localization/language/languages.dart';
import 'package:ft_hangout/src/bloc/bloc_provider.dart';
import 'package:ft_hangout/src/bloc/message_bloc.dart';
import 'package:ft_hangout/src/bloc/theme_bloc.dart';
import 'package:ft_hangout/src/models/message.dart';

class MessagePage extends StatefulWidget {
  //le plus recent -> index 0;
  final int idContact;

  MessagePage({Key key, @required this.idContact}) : super(key: key);
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<Map> messageList = [];

  _sendMessage(BuildContext context, String message, int timeStamp) {
    BlocProvider.of<MessageBloc>(context).sendMessage(
      Message(
          message: message,
          time: timeStamp,
          idContact: widget.idContact,
          fromMe: 1),
    );
  }

  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("nom"),
        //ajouter popumenu avec Details
      ),
      body: StreamBuilder(
          stream: BlocProvider.of<MessageBloc>(context).messageStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              BlocProvider.of<MessageBloc>(context)
                  .getMessage(widget.idContact);
            }
            messageList = BlocProvider.of<MessageBloc>(context).messageList;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: messageList.length,
                    itemBuilder: (BuildContext context, int index) {
                      // bool position = messageList.length
                      DateTime messageTime =
                          DateTime.fromMillisecondsSinceEpoch(
                              messageList[index]["time"]);
                      print(
                          "time :${messageList[index]["time"]} : $messageTime");
                      return Container(
                        alignment: Alignment.centerLeft, //Position fromMe
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: BlocProvider.of<ThemeBloc>(context)
                                          .darktheme
                                      ? Colors.black38
                                      : Colors.grey.shade300,
                                  border: Border.all(
                                      width: 0.0, style: BorderStyle.none),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(7.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // position subtitleFromMe
                                    children: [
                                      Text(
                                        messageList[index]["message"]
                                            .toString(),
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .color,
                                            fontSize: 13),
                                      ),
                                      Text(
                                        "${messageTime.day}/${messageTime.month}/${messageTime.year} ${messageTime.hour}h${messageTime.minute}",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                .color,
                                            fontSize: 7),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            _sendMessage(context, _controller.text,
                                DateTime.now().millisecondsSinceEpoch);
                            FocusScope.of(context).unfocus();
                            _controller.text = "";
                          }),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      hintText: "message",
                    ),
                    onSubmitted: (value) {
                      _sendMessage(context, value,
                          DateTime.now().millisecondsSinceEpoch);
                      FocusScope.of(context).unfocus();
                      _controller.text = "";
                    },
                  ),
                )
              ],
            );
          }),
    );
  }
}
