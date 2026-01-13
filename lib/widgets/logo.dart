import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/img/logo.png',
      height: 180,
      width: 180,
      fit: BoxFit.contain,
    );
  }
}
