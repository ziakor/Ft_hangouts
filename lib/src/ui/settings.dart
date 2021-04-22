import 'package:flutter/material.dart';
import 'package:ft_hangout/localization/language/languages.dart';
import 'package:ft_hangout/src/bloc/bloc_provider.dart';
import 'package:ft_hangout/src/bloc/language_bloc.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Color headerColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context).settings),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.color_lens,
                      color: Colors.red,
                    ),
                    title: Text(Languages.of(context).settingsTheme),
                    onTap: () {
                      //Open edit Language
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
                      color: Colors.red,
                    ),
                    title: Text(Languages.of(context).settingsHeaderColor),
                    onTap: () {
                      //Open edit Color
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
                      color: Colors.red,
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
    );
  }
}

Widget _buildLanguageDialog(BuildContext context) {
  // convert en stfull
  List<Map<String, String>> _languageList = [
    {"title": Languages.of(context).languageList[0], "languageCode": "en"},
    {"title": Languages.of(context).languageList[1], "languageCode": "fr"}
  ];
  int _currentIndex = (_languageList.indexWhere((element) =>
          element["languageCode"] ==
          BlocProvider.of<LanguageBloc>(context).selectedLocale.toString())) |
      0;
  print("$_currentIndex << current");
  void _changeLanguage(BuildContext context, String newLanguage) {
    BlocProvider.of<LanguageBloc>(context).changeLanguage(newLanguage);
  }

  final int savedIndex = _currentIndex;
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
                if (savedIndex != _currentIndex) print("SDNJOKSDNKLSDNK");
                Navigator.pop(context, null);
              },
              child: Text(Languages.of(context).cancel))
        ],
        //! A DEBUG
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
