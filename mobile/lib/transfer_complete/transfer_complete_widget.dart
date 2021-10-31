import 'package:cm2p/icon_widget.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class TransferCompleteWidget extends StatefulWidget {
  TransferCompleteWidget({Key key}) : super(key: key);

  @override
  _TransferCompleteWidgetState createState() => _TransferCompleteWidgetState();
}

class _TransferCompleteWidgetState extends State<TransferCompleteWidget> {
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.tertiaryColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          'Success',
          style: FlutterFlowTheme.subtitle2.override(
            fontFamily: 'Lexend Deca',
            color: FlutterFlowTheme.textColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 1,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            bottom: 53,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff141e55), Colors.black],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Color(0xff3c5af9),
                  ),
                  SizedBox(height: 60),
                  Container(
                    width: 163,
                    height: 163,
                    child: Stack(
                      children: [
                        Container(
                          width: 163,
                          height: 163,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff38dd1d),
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 78,
                              height: 78,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset('assets/images/check.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconWidget(''),
                          Text(
                            "100’000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Available Balance",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 60),
                ],
              ),
              FFButtonWidget(
                onPressed: () => Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    duration: Duration(milliseconds: 200),
                    reverseDuration: Duration(milliseconds: 200),
                    child: NavBarPage(initialPage: 'MY_Card'),
                  ),
                ),
                text: 'Go to Account',
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
                loading: _loadingButton,
              )
            ],
          ),
        ),
      ),
    );
  }
}
