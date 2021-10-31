import 'package:cm2p/utils.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CreditCardWidget extends StatelessWidget {
  bool active;
  String name;
  double balance;

  CreditCardWidget({@required this.active, @required this.name, this.balance});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getBalance(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            print(snapshot.data);
            return Container(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.20,
              decoration: active
                  ? BoxDecoration(color: FlutterFlowTheme.tertiaryColor)
                  : null,
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Color(0xFF4B39EF),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                shadowColor: FlutterFlowTheme.primaryColor,
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(-0.92, -0.67),
                      child: Image.asset('assets/images/JuliusLogo.png'),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-0.79, 0.02),
                      child: Text(
                        name,
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Lexend Deca',
                          color: FlutterFlowTheme.creditCardText,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-0.79, 0.62),
                      child: Text(
                        'CHF',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Lexend Deca',
                          color: FlutterFlowTheme.textColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-0.09, 0.62),
                      child: Text(
                        currencyFormat.format(snapshot.data),
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Lexend Deca',
                          color: FlutterFlowTheme.textColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-0.79, 0.85),
                      child: Text(
                        'Available Balance',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Lexend Deca',
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Future<double> _getBalance() async {
    return balance != null ? Future<double>.value(balance) : getFiatBalance();
  }
}
