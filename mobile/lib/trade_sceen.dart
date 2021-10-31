import 'package:flutter/material.dart';

class TradeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/tradeScreen.png',
            width: MediaQuery.of(context).size.width, fit: BoxFit.cover)
      ],
    );
  }
}
