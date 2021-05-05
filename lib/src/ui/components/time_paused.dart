import 'package:flutter/material.dart';
import 'package:ft_hangout/src/bloc/PausedTime.dart';
import 'package:ft_hangout/src/bloc/bloc_provider.dart';

class TimePaused extends StatefulWidget {
  TimePaused({Key key}) : super(key: key);

  @override
  _TimePausedState createState() => _TimePausedState();
}

class _TimePausedState extends State<TimePaused> {
  DateTime pausedTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: BlocProvider.of<PausedTimeBloc>(context).appLifecycleStream,
        builder: (context, snapshot) {
          pausedTime = snapshot.data;
          return Container(
            child: Visibility(
              visible: pausedTime != null,
              child: Container(
                height: 50,
                child: Card(
                    elevation: 6.0,
                    color: Colors.grey.shade800,
                    child: Center(
                        child: Text(pausedTime != null
                            ? "${pausedTime.hour} h ${pausedTime.minute}m ${pausedTime.second}s"
                            : ""))),
              ),
            ),
          );
        });
  }
}
