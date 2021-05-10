import 'package:calculator_app/class/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Color color;
  final String value;
  final int flex;
  final Function(String) callback;
  const CustomButton({Key key, this.color = Colors.grey, this.value, this.callback, this.flex = 1})
      : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: widget.flex,
        child: GestureDetector(
          onTapDown: (TapDownDetails tapDownDetails) {
            setState(() {
              tapped = true;
            });
          },
          onTapUp: (TapUpDetails tap) {
            setState(() {
              tapped = false;
            });
          },
          onTap: () {
            widget.callback(widget.value);
          },

          child: Container(

            color: tapped ?  widget.color.withOpacity(0.8) : widget.color,
            child: Center(child: Text(widget.value, style : Constants.MAIN_TEXT_STYLE)),
          ),
        ));
  }
}
