import 'package:flutter/material.dart';

class Warning extends StatelessWidget {
  final String warning;
  Warning({@required this.warning});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(warning == 'Error' ? 'Some Error Happened' : 'Loading'),
        ),
      ),
    );
  }
}
