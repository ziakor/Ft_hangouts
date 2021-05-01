import 'package:flutter/material.dart';
import 'package:ft_hangout/src/bloc/bloc_provider.dart';
import 'package:ft_hangout/src/bloc/contact_bloc.dart';
import 'package:ft_hangout/src/bloc/header_color_bloc.dart';
import 'package:ft_hangout/src/bloc/message_bloc.dart';
import 'package:ft_hangout/src/bloc/theme_bloc.dart';
import 'package:ft_hangout/src/helpers/DatabaseHelper.dart';
import 'package:ft_hangout/src/bloc/language_bloc.dart';
import 'ui/main.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    DatabaseHelper.instance.getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageBloc>(
      bloc: LanguageBloc(),
      child: BlocProvider<HeaderColorBloc>(
        bloc: HeaderColorBloc(),
        child: BlocProvider<ThemeBloc>(
          bloc: ThemeBloc(),
          child: BlocProvider<ContactBloc>(
            bloc: ContactBloc(),
            child: BlocProvider<MessageBloc>(
              bloc: MessageBloc(),
              child: Main(),
            ),
          ),
        ),
      ),
    );
  }
}
