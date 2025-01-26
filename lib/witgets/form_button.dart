import 'package:flutter/material.dart';

enum ButtonType { small, big }

class FormButton extends StatelessWidget {
  final bool disabled;
  final String text;
  final ButtonType buttonType;

  FormButton({
    super.key,
    required this.disabled,
    required this.text,
    required this.buttonType,
  });

  final Map<String, dynamic> _smallButtonSpec = {
    "type": ButtonType.small,
    "width": 80.0,
    "height": 40.0,
    "fontSize": 14.0,
  };

  final Map<String, dynamic> _biglButtonSpec = {
    "type": ButtonType.big,
    "width": 300.0,
    "height": 60.0,
    "fontSize": 18.0,
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonType == ButtonType.small
          ? _smallButtonSpec['height']
          : _biglButtonSpec['height'],
      width: buttonType == ButtonType.small
          ? _smallButtonSpec['width']
          : MediaQuery.of(context).size.width * 0.8,
      child: AnimatedContainer(
        duration: const Duration(microseconds: 300),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: disabled ? Colors.grey.shade600 : Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(microseconds: 300),
          style: TextStyle(
            color: disabled ? Colors.grey.shade400 : Colors.white,
            fontSize: buttonType == ButtonType.small
                ? _smallButtonSpec['fontSize']
                : _biglButtonSpec['fontSize'],
            fontWeight: FontWeight.w800,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
