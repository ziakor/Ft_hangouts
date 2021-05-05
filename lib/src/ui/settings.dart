import 'package:flutter/material.dart';
import 'package:ft_hangout/localization/language/languages.dart';
import 'package:ft_hangout/src/bloc/PausedTime.dart';
import 'package:ft_hangout/src/bloc/bloc_provider.dart';
import 'package:ft_hangout/src/bloc/header_color_bloc.dart';
import 'package:ft_hangout/src/bloc/language_bloc.dart';
import 'package:ft_hangout/src/bloc/theme_bloc.dart';
import 'package:ft_hangout/src/ui/components/time_paused.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context).settings),
      ),
      body: GestureDetector(
        onTap: () => BlocProvider.of<PausedTimeBloc>(context).close(),
        child: Container(
          constraints: BoxConstraints.expand(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TimePaused(),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.color_lens,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Text(Languages.of(context).settingsTheme),
                        onTap: () {
                          showDialog(
                              context: context, builder: _buildThemeDialog);
                        },
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                      Container(
                        width: double.infinity,
                        height: 0.5,
                        color: Colors.grey,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.colorize,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Text(Languages.of(context).settingsHeaderColor),
                        onTap: () {
                          showDialog(
                              context: context, builder: _buildHeaderDialog);
                        },
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                      Container(
                        width: double.infinity,
                        height: 0.5,
                        color: Colors.grey,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.language,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Text(Languages.of(context).settingsLanguage),
                        onTap: () {
                          showDialog(
                              context: context, builder: _buildLanguageDialog);
                        },
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildHeaderDialog(BuildContext context) {
  Color _currentColor =
      BlocProvider.of<HeaderColorBloc>(context).selectedHeaderColor;
  final List<List<Color>> listColor = [
    [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.indigo,
    ],
    [
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
    ],
    [
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
    ],
    [
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.grey,
    ]
  ];

  void _changeColor(BuildContext context, Color newColor) {
    _currentColor = newColor;
    BlocProvider.of<HeaderColorBloc>(context).changeHeaderColor(newColor);
  }

  return StatefulBuilder(builder: (context, setState2) {
    return AlertDialog(
      title: Text(Languages.of(context).settingsHeaderColorTitle),
      buttonPadding: EdgeInsets.symmetric(vertical: 0.0),
      actionsPadding: EdgeInsets.only(right: 9),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context, null);
            },
            child: Text(Languages.of(context).close))
      ],
      content: Container(
        width: double.minPositive,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: listColor.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: index + 1 < listColor.length
                  ? EdgeInsets.only(bottom: 10.0)
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipOval(
                    child: Material(
                      color: listColor[index][0], // button color
                      child: InkWell(
                        splashColor: Colors.black45, // inkwell color
                        child: SizedBox(
                            width: 45,
                            height: 45,
                            child: _currentColor == listColor[index][0]
                                ? Icon(Icons.check)
                                : null),
                        onTap: () {
                          setState2(() {
                            _currentColor = listColor[index][0];
                          });
                          _changeColor(context, listColor[index][0]);
                        },
                      ),
                    ),
                  ),
                  ClipOval(
                    child: Material(
                      color: listColor[index][1], // button color
                      child: InkWell(
                        splashColor: Colors.black45, // inkwell color
                        child: SizedBox(
                            width: 45,
                            height: 45,
                            child: _currentColor == listColor[index][1]
                                ? Icon(Icons.check)
                                : null),
                        onTap: () {
                          setState2(() {
                            _currentColor = listColor[index][0];
                          });
                          _changeColor(context, listColor[index][1]);
                        },
                      ),
                    ),
                  ),
                  ClipOval(
                    child: Material(
                      color: listColor[index][2], // button color
                      child: InkWell(
                        splashColor: Colors.black45, // inkwell color
                        child: SizedBox(
                            width: 45,
                            height: 45,
                            child: _currentColor == listColor[index][2]
                                ? Icon(Icons.check)
                                : null),
                        onTap: () {
                          setState2(() {
                            _currentColor = listColor[index][0];
                          });
                          _changeColor(context, listColor[index][2]);
                        },
                      ),
                    ),
                  ),
                  ClipOval(
                    child: Material(
                      color: listColor[index][3], // button color
                      child: InkWell(
                        splashColor: Colors.black45, // inkwell color
                        child: SizedBox(
                            width: 45,
                            height: 45,
                            child: _currentColor == listColor[index][3]
                                ? Icon(Icons.check)
                                : null),
                        onTap: () {
                          setState2(() {
                            _currentColor = listColor[index][0];
                          });
                          _changeColor(context, listColor[index][3]);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  });
}

Widget _buildLanguageDialog(BuildContext context) {
  // convert en stfull
  List<Map<String, String>> _languageList = [
    {"title": Languages.of(context).languageList[0], "languageCode": "en"},
    {"title": Languages.of(context).languageList[1], "languageCode": "fr"}
  ];
  int _currentIndex =
      BlocProvider.of<LanguageBloc>(context).selectedLocale != null
          ? _languageList.indexWhere((element) =>
              element["languageCode"] ==
              BlocProvider.of<LanguageBloc>(context).selectedLocale.toString())
          : 0;

  void _changeLanguage(BuildContext context, String newLanguage) {
    BlocProvider.of<LanguageBloc>(context).changeLanguage(newLanguage);
  }

  return StatefulBuilder(
    builder: (
      context,
      setState2,
    ) {
      return AlertDialog(
        title: Text(Languages.of(context).settingsLanguageTitle),
        contentPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.symmetric(vertical: 0.0),
        actionsPadding: EdgeInsets.only(right: 9),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.pop(context, null);
              },
              child: Text(Languages.of(context).close))
        ],
        content: Container(
          width: double.minPositive,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _languageList.length,
            itemBuilder: (BuildContext context, int index) {
              return RadioListTile(
                value: index,
                dense: true,
                activeColor: Colors.black,
                groupValue: _currentIndex,
                title: Text(_languageList[index]["title"]),
                onChanged: (val) {
                  setState2(() {
                    _currentIndex = val;
                  });
                  _changeLanguage(context, _languageList[val]["languageCode"]);
                },
              );
            },
          ),
        ),
      );
    },
  );
}

Widget _buildThemeDialog(BuildContext context) {
  List<String> themeList = [
    Languages.of(context).themeLight,
    Languages.of(context).themeDark,
  ];
  int _currentIndex = BlocProvider.of<ThemeBloc>(context).darktheme ? 1 : 0;
  void _changeTheme(BuildContext context, int index) {
    BlocProvider.of<ThemeBloc>(context).changeTheme(index == 0 ? false : true);
  }

  return StatefulBuilder(
    builder: (
      context,
      setState2,
    ) {
      return AlertDialog(
        title: Text(Languages.of(context).settingsLanguageTitle),
        contentPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.symmetric(vertical: 0.0),
        actionsPadding: EdgeInsets.only(right: 9),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.pop(context, null);
              },
              child: Text(Languages.of(context).close))
        ],
        content: Container(
          width: double.minPositive,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: themeList.length,
            itemBuilder: (BuildContext context, int index) {
              return RadioListTile(
                value: index,
                dense: true,
                activeColor: Colors.black,
                groupValue: _currentIndex,
                title: Text(themeList[index]),
                onChanged: (val) {
                  setState2(() {
                    _currentIndex = val;
                  });
                  _changeTheme(context, val);
                },
              );
            },
          ),
        ),
      );
    },
  );
}
