import 'package:cm2p/algorand.dart';
import 'package:cm2p/auth/auth_util.dart';
import 'package:cm2p/backend/backend.dart';
import 'package:cm2p/transfer_complete/transfer_complete_widget.dart';
import 'package:cm2p/utils.dart';

import '../components/credit_card_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ConvertToTokenWidget extends StatefulWidget {
  ConvertToTokenWidget({Key key}) : super(key: key);

  @override
  _ConvertToTokenWidgetState createState() => _ConvertToTokenWidgetState();
}

class _ConvertToTokenWidgetState extends State<ConvertToTokenWidget> {
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textController;
  bool active = true;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: FlutterFlowTheme.primaryColor,
            size: 24,
          ),
        ),
        title: Text(
          'Convert',
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [
              FlutterFlowTheme.gradientLight,
              FlutterFlowTheme.gradientDark
            ],
          ),
        ),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text('SELECT ACCOUNT',
                    style: TextStyle(color: FlutterFlowTheme.textColor)),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: CreditCardWidget(
                          active: active,
                          name: 'JB Saving...4442',
                        ),
                        onTap: () {
                          if (!active) {
                            textController.text = '0';
                            setState(() {
                              active = !active;
                            });
                          }
                        },
                      ),
                      InkWell(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: CreditCardWidget(
                            active: !active,
                            name: 'JB Checking...7832',
                            balance: 50000,
                          ),
                        ),
                        onTap: () {
                          if (active) {
                            textController.text = '0';
                            setState(() {
                              active = !active;
                            });
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 20, 0, 4),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Enter Amount',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.bodyText2.override(
                        fontFamily: 'Lexend Deca',
                        color: FlutterFlowTheme.textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 6),
                      child: Text(
                        'CHF',
                        style: FlutterFlowTheme.bodyText1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                      child: Container(
                        width: 200,
                        child: TextField(
                          controller: textController,
                          style: FlutterFlowTheme.title1,
                          textAlign: TextAlign.center,
                          onChanged: (text) {
                            setState(() {});
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                child: Container(
                  width: 330,
                  height: 2,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.tertiaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    textController.value.text,
                    style: TextStyle(
                        color: FlutterFlowTheme.textColor, fontSize: 24),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CHF-S Price',
                          style: TextStyle(
                              color: FlutterFlowTheme.textColor, fontSize: 20),
                        ),
                        Text(
                          'Buy',
                          style: TextStyle(
                              color: FlutterFlowTheme.textColor, fontSize: 20),
                        ),
                        Text(
                          'Swi\'Fi Fee',
                          style: TextStyle(
                              color: FlutterFlowTheme.textColor, fontSize: 20),
                        ),
                        Text(
                          'Total',
                          style: TextStyle(
                              color: FlutterFlowTheme.textColor, fontSize: 20),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'CHF 1',
                          style: TextStyle(
                              color: FlutterFlowTheme.textColor, fontSize: 20),
                        ),
                        Text(
                          'CHF-S ${textController.value.text}',
                          style: TextStyle(
                              color: FlutterFlowTheme.textColor, fontSize: 20),
                        ),
                        Text(
                          getAmount(),
                          style: TextStyle(
                              color: FlutterFlowTheme.textColor, fontSize: 20),
                        ),
                        Text(
                          'CHF ${textController.value.text}',
                          style: TextStyle(
                              color: FlutterFlowTheme.textColor, fontSize: 20),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Text(
                    'Proccessed by Julius Baer/Crypto markets are unique check the terms of conditions for more details.',
                    style: FlutterFlowTheme.bodyText2.override(
                      fontFamily: 'Lexend Deca',
                      color: Color(0xFF8B97A2),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  )),
              FFButtonWidget(
                onPressed: active &&
                        textController.value.text != '' &&
                        textController.value.text != '0'
                    ? () async {
                        setState(() => _loadingButton = true);
                        try {
                          await fundWallet(
                              int.tryParse(textController.value.text) * 100);
                          await Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.bottomToTop,
                              duration: Duration(milliseconds: 220),
                              reverseDuration: Duration(milliseconds: 220),
                              child: TransferCompleteWidget(),
                            ),
                          );
                        } finally {
                          setState(() => _loadingButton = false);
                        }
                      }
                    : null,
                text: 'Convert',
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

  String getAmount() {
    try {
      return (double.tryParse(textController.value.text) * 0.0025)
          .toStringAsFixed(2);
    } catch (e) {
      return '';
    }
  }
}
