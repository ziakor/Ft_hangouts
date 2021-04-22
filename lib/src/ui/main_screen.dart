import 'package:flutter/material.dart';
import 'package:ft_hangout/localization/language/languages.dart';
import 'package:ft_hangout/src/bloc/bloc_provider.dart';
import 'package:ft_hangout/src/bloc/language_bloc.dart';
import 'package:ft_hangout/src/scale_route.dart';
import 'package:ft_hangout/src/ui/settings.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _onSelectedPopupMenu(BuildContext context, int value) {
    switch (value) {
      case 0:
        Navigator.push(context, ScaleRoute(page: Settings()));
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ft_hangouts"),
        actions: [
          PopupMenuButton(
              onSelected: (value) {
                _onSelectedPopupMenu(context, value);
              },
              offset: Offset(0, -15),
              color: Colors.grey.shade900,
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
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                      ],
                    ),
                  )
                ];
              })
        ],
      ),
      body: Column(children: [
        TextButton(
            onPressed: () =>
                BlocProvider.of<LanguageBloc>(context).changeLanguage("en"),
            child: Text(
              Languages.of(context).appName,
              style: Theme.of(context).textTheme.bodyText1,
            ))
      ]),
    );
  }
}
