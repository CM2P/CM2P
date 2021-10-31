import 'package:cm2p/flutter_flow/flutter_flow_theme.dart';
import 'package:cm2p/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  String photoUrl;
  bool small;

  AvatarWidget(this.photoUrl, [this.small = false]);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: small ? 22 : 90,
      height: small ? 22 : 90,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.darkBackground,
        shape: BoxShape.circle,
      ),
      child: Image.network(
        valueOrDefault<String>(
          photoUrl,
          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/finance-app-sample-kugwu4/assets/ijvuhvqbvns6/uiAvatar@2x.png',
        ),
      ),
    );
  }
}
