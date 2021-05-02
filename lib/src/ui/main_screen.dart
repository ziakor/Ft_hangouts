import 'package:flutter/material.dart';
import 'package:ft_hangout/localization/language/languages.dart';
import 'package:ft_hangout/src/bloc/bloc_provider.dart';
import 'package:ft_hangout/src/bloc/contact_bloc.dart';
import 'package:ft_hangout/src/bloc/contact_detail_bloc.dart';
import 'package:ft_hangout/src/bloc/theme_bloc.dart';
import 'package:ft_hangout/src/ui/components/scale_route.dart';
import 'package:ft_hangout/src/ui/detail_contact.dart';
import 'package:ft_hangout/src/ui/message.dart';
import 'package:ft_hangout/src/ui/new_contact.dart';
import 'package:ft_hangout/src/ui/settings.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List _listContact = [];
  bool _editContact = false;
  int _selectedContactIndex;
  void _onSelectedPopupMenu(BuildContext context, int value) {
    switch (value) {
      case 0:
        Navigator.push(context, ScaleRoute(page: Settings()));
        break;
      default:
    }
  }

  void _newContact(BuildContext context) {
    Navigator.push(context, ScaleRoute(page: NewContact()));
  }

  void _toMessage(BuildContext context, int idContact) {
    Navigator.push(
        context,
        ScaleRoute(
            page: MessagePage(
          idContact: idContact,
        )));
  }

  void handleDetailContact(int idContact) {
    setState(
      () {
        _editContact = false;
        _selectedContactIndex = null;
      },
    );
    Navigator.push(
        context,
        ScaleRoute(
            page: BlocProvider(
                bloc: ContactDetailBloc(),
                child: DetailContactEditable(
                  contactId: idContact,
                ))));
  }

  void _deleteContact(int index) async {
    print("index : ${_listContact[index]["id"]}");
    BlocProvider.of<ContactBloc>(context).removeContact(index);
    _listContact.removeAt(index);
    setState(() {
      _editContact = false;
      _selectedContactIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: BlocProvider.of<ContactBloc>(context).contactStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            BlocProvider.of<ContactBloc>(context).getContactList();
          } else {
            // print(snapshot.data);
            _listContact = snapshot.data;
          }
          return Scaffold(
            appBar: _editContact == false
                ? AppBar(
                    title: Text("Ft_hangouts"),
                    actions: [
                      PopupMenuButton(
                        onSelected: (value) {
                          _onSelectedPopupMenu(context, value);
                        },
                        offset: Offset(0, -15),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.more_vert),
                        ),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              value: 0,
                              child: Column(
                                children: [
                                  Text(
                                    Languages.of(context).settings,
                                  )
                                ],
                              ),
                            )
                          ];
                        },
                      )
                    ],
                  )
                : AppBar(
                    leading: IconButton(
                      splashRadius: 25,
                      icon: Icon(
                        Icons.close,
                        size: 35,
                      ),
                      tooltip: Languages.of(context).close,
                      onPressed: () {
                        setState(
                          () {
                            _editContact = false;
                            _selectedContactIndex = null;
                          },
                        );
                      },
                    ),
                    actions: [
                      IconButton(
                        splashRadius: 25,
                        icon: Icon(Icons.account_circle),
                        tooltip: Languages.of(context).editContact,
                        onPressed: () {
                          handleDetailContact(
                              _listContact[_selectedContactIndex]["id"]);
                        },
                      ),
                      IconButton(
                        splashRadius: 25,
                        icon: Icon(Icons.delete),
                        tooltip: Languages.of(context).deleteContact,
                        onPressed: () {
                          _deleteContact(_selectedContactIndex);
                        },
                      ),
                    ],
                  ),
            body: ListView.separated(
              shrinkWrap: true,
              itemCount: _listContact.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                    key: ValueKey(_listContact[index]),
                    direction: DismissDirection.startToEnd,
                    background: Container(
                        color: Colors.red.shade800,
                        alignment: Alignment.centerLeft,
                        child: Text("    ${Languages.of(context).delete} ?")),
                    onDismissed: (direction) {
                      _deleteContact(index);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          Languages.of(context).contactDeletedMessage,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                        ),
                        duration: Duration(seconds: 2),
                        backgroundColor: Theme.of(context).backgroundColor,
                      ));
                    },
                    child: ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.account_circle,
                          size: 40,
                        ),
                      ),
                      selected: _selectedContactIndex == index ? true : false,
                      selectedTileColor:
                          BlocProvider.of<ThemeBloc>(context).darktheme
                              ? Colors.black38
                              : Colors.grey.shade300,
                      title: Text(
                          "${_listContact[index]["firstName"]} ${_listContact[index]["lastName"] != null ? _listContact[index]["lastName"] : ""}",
                          style: Theme.of(context).textTheme.bodyText1),
                      subtitle: Text(
                        "",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      onTap: () {
                        if (_editContact)
                          setState(() {
                            _editContact = false;
                          });
                        else {
                          _toMessage(context, _listContact[index]["id"]);
                        }
                      },
                      onLongPress: () {
                        setState(() {
                          _editContact = true;
                          _selectedContactIndex = index;
                        });
                      },
                    ));
              },
              separatorBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: 0.5,
                  color: Theme.of(context).dividerColor,
                );
              },
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () => _newContact(context),
              tooltip: Languages.of(context).floatingNewContact,
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          );
        });
  }
}
