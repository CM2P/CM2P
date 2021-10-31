import 'package:cm2p/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  String text;

  IconWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          text.length > 0 ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/TokenIcon.png',
          height: 30,
        ),
        Text(
          ' CHF-S ',
          style: TextStyle(color: FlutterFlowTheme.textColor),
        ),
        Text(
          text,
          style: TextStyle(color: FlutterFlowTheme.textColor, fontSize: 24),
        ),
      ],
    );
  }
}
