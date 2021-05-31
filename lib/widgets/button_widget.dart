import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final Color color;
  // final dynamic onPressed;
  final bool pressed;

  const ButtonWidget({this.text, this.onClicked, this.color, this.pressed});

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(52),
          primary: this.color,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        onPressed:this.pressed ? onClicked : null,
      );
}
