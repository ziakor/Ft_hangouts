import 'package:flutter/material.dart';
import 'package:ft_hangout/localization/language/languages.dart';
import 'package:ft_hangout/src/bloc/bloc_provider.dart';
import 'package:ft_hangout/src/bloc/header_color_bloc.dart';
import 'package:ft_hangout/src/ui/components/scale_route.dart';
import 'package:ft_hangout/src/ui/settings.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List _listContact = [
    {"name": "dimitri hauet", "description": "bitasse"},
    {"name": "dimitri hauet", "description": "bitasse"},
    {"name": "dimitri hauet", "description": "bitasse"},
    {"name": "dimitri hauet", "description": "bitasse"},
    {"name": "dimitri hauet", "description": "bitasse"},
    {"name": "dimitri hauet", "description": "bitasse"},
    {"name": "dimitri hauet", "description": "bitasse"},
    {"name": "dimitri hauet", "description": "bitasse"},
    {"name": "dimitri hauet", "description": "bitasse"},
    {"name": "dimitri hauet", "description": "bitasse"},
    {"name": "dimitri hauet", "description": "bitasse"},
    {"name": "dimitri hauet", "description": "bitasse"},
  ];
  bool editContact = false;
  void _onSelectedPopupMenu(BuildContext context, int value) {
    switch (value) {
      case 0:
        Navigator.push(context, ScaleRoute(page: Settings()));
        break;
      default:
    }
  }

  void _editContact() {}

  void _deleteContact() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: editContact == false
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
                      editContact = false;
                    },
                  );
                },
              ),
              actions: [
                IconButton(
                  splashRadius: 25,
                  icon: Icon(Icons.edit),
                  tooltip: Languages.of(context).editContact,
                  onPressed: () {},
                ),
                IconButton(
                  splashRadius: 25,
                  icon: Icon(Icons.delete),
                  tooltip: Languages.of(context).deleteContact,
                  onPressed: () {},
                ),
              ],
            ),
      body: ListView.separated(
        shrinkWrap: true,
        itemCount: _listContact.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
              key: ValueKey(_listContact[index]),
              background: Container(
                color: Colors.red.shade800,
              ),
              onDismissed: (direction) {
                print(direction);
                setState(() {
                  _listContact.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("contact supprimé"),
                  backgroundColor: Theme.of(context).backgroundColor,
                ));
              },
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(
                    Icons.account_circle,
                    size: 40,
                  ),
                ),
                title: Text(_listContact[index]["name"]),
                subtitle: Text(_listContact[index]["description"]),
                onTap: () {
                  if (editContact)
                    setState(() {
                      editContact = false;
                    });
                  else {
                    //show message
                  }
                  //show message
                },
                onLongPress: () {
                  setState(() {
                    editContact = true;
                  });
                },
              ));
        },
        separatorBuilder: (context, index) {
          return Container(
            width: double.infinity,
            height: 0.5,
            color: Colors.grey.shade300,
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: Languages.of(context).floatingNewContact,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor:
            BlocProvider.of<HeaderColorBloc>(context).selectedHeaderColor,
      ),
    );
  }
}
