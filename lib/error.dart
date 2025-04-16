import 'package:flutter/material.dart';

class CustomErrorMessage extends StatelessWidget {
  const CustomErrorMessage({super.key, required this.origin, this.text});
  final String origin;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      origin.isNotEmpty ? 'O campo "$origin" não pode ser vazio!' : text!,
    );
  }
}
