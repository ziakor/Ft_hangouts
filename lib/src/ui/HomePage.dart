import 'package:flutter/material.dart';
import 'package:ft_hangout/localization/language/languages.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The [AppBar] title text should update its message
        // according to the system locale of the target platform.
        // Switching between English and Spanish locales should
        // cause this text to update.
        title: Text("Title Text"),
      ),
      body: Text(Languages.of(context).appName),
    );
  }
}
