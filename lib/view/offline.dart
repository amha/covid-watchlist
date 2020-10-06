import 'package:flutter/material.dart';

class Offline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Text(
        "Offline at the moment",
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}
