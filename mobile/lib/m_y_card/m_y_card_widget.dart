import 'package:cm2p/avatar_widget.dart';
import 'package:cm2p/convert_to_token.dart';
import 'package:cm2p/flutter_flow/flutter_flow_widgets.dart';
import 'package:cm2p/utils.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/pause_card_widget.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../payment_details/payment_details_widget.dart';
import '../transaction_a_d_d/transaction_a_d_d_widget.dart';
import '../transfer_funds/transfer_funds_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MYCardWidget extends StatefulWidget {
  MYCardWidget({Key key}) : super(key: key);

  @override
  _MYCardWidgetState createState() => _MYCardWidgetState();
}

class _MYCardWidgetState extends State<MYCardWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'rowOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      fadeIn: true,
      slideOffset: Offset(0, -30),
      scale: 0.4,
    ),
    'containerOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      fadeIn: true,
      slideOffset: Offset(0, -49),
    ),
    'containerOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      delay: 50,
      fadeIn: true,
      slideOffset: Offset(0, -51),
    ),
    'containerOnPageLoadAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      delay: 80,
      fadeIn: true,
      slideOffset: Offset(0, -69),
    ),
  };
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          colors: [
            FlutterFlowTheme.gradientLight,
            FlutterFlowTheme.gradientDark
          ],
        ),
      ),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo-white.png',
                  width: 44,
                ),
                SizedBox(
                  height: 128,
                ),
                FutureBuilder(
                    future: UsersRecord.getDocument(currentUserReference).first,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  AvatarWidget(snapshot.data.photoUrl, true),
                                  Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Text(
                                      'Welcome, ',
                                      style: FlutterFlowTheme.bodyText3,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data.displayName,
                                    style: FlutterFlowTheme.bodyText3,
                                  ),
                                ],
                              ),
                              Text(
                                'Portfolio Balance',
                                style: FlutterFlowTheme.title3,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 6),
                                    child: Text('CHF',
                                        style: FlutterFlowTheme.bodyText3),
                                  ),
                                  Text(
                                    currencyFormat.format(
                                        snapshot.data.fiatWealth +
                                            snapshot.data.chfSWealth),
                                    style: FlutterFlowTheme.title1,
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 34),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FFButtonWidget(
                onPressed: () => Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    duration: Duration(milliseconds: 200),
                    reverseDuration: Duration(milliseconds: 200),
                    child: ConvertToTokenWidget(
                      withBackButton: true,
                    ),
                  ),
                ),
                text: 'Get CHF-S Stablecoins',
                options: FFButtonOptions(
                  width: 360,
                  height: 60,
                  color: FlutterFlowTheme.primaryColor,
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'SF Pro',
                    color: Colors.white,
                    useGoogleFonts: false,
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 50,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
