// Custom button takes multiple arguments to render the desired button
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Icon icon;
  final Color color;
  final Function onTap;
  CustomButton({this.text, this.icon, this.color, this.style, this.onTap});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      minWidth: double.maxFinite,
      height: 50,
      onPressed: () {
        if (onTap != null) {
          onTap();
        }
      },
      color: color != null ? color : Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          icon != null ? icon : Icon(FontAwesomeIcons.sign),
          SizedBox(width: 10),
          Text(text,
              style: style != null
                  ? style
                  : Theme.of(context).textTheme.headline1),
        ],
      ),
      textColor: color != Colors.white ? Colors.white : Colors.black,
    );
  }
}
