import 'package:flutter/material.dart';

class BlockButtonWidget extends StatelessWidget {
  const BlockButtonWidget(
      {Key? key,
      @required this.color,
      @required this.text,
      @required this.onPressed})
      : super(key: key);

  final ButtonStyle? color;
  final Text? text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: color,
      onPressed: onPressed,
      child: text!,
    );
  }
}
