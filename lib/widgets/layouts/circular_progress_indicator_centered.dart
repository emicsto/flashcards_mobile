import 'package:flutter/material.dart';

class CircularProgressIndicatorCentered extends StatelessWidget {
  const CircularProgressIndicatorCentered({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[CircularProgressIndicator()],
        ));
  }
}