import 'package:flutter/material.dart';

class InvestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/investScreen.png',
            width: MediaQuery.of(context).size.width, fit: BoxFit.cover)
      ],
    );
  }
}
