import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final Function()? function;
  final Color borderColor;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  const FollowButton({super.key, this.function, required this.borderColor, required this.text, required this.textColor, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: TextButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
            // color: Colors.deepOrange.shade200
            color: backgroundColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.bold),),
          width: 210,
          height: 27,
        ),
      ),
    );
  }
}