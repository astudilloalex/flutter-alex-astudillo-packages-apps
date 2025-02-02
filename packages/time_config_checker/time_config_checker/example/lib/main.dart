import 'package:flutter/material.dart';
import 'package:time_config_checker/time_config_checker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Time Config Checker')),
        body: Center(
          child: FutureBuilder<TimeConfig>(
            future: const TimeConfigChecker().getTimeConfig(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final config = snapshot.data!;
                return Text(
                  'Automatic Time: ${config.isAutomaticTime}\n'
                  'Automatic Time Zone: ${config.isAutomaticTimeZone}',
                );
              } else {
                return const Text('No data available');
              }
            },
          ),
        ),
      ),
    );
  }
}
