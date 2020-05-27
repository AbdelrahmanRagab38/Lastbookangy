import 'package:flutter/material.dart';

class CircluarButton extends StatelessWidget {
  final String icon;
  final Function onPress;
  CircluarButton({this.icon, this.onPress});
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Image.asset(icon),
      ),
      onPressed: onPress,
      constraints: BoxConstraints.tightFor(width: 56.0, height: 56.0),
      shape: CircleBorder(),
      fillColor: Colors.green,
      elevation: 0.0,
    );
  }
}
