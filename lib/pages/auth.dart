import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:async';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String _authorized = 'Not Authorized';
  int counter = 0;

  Future _authenticate() async{
    bool authenticated = false;
    try {
      var localAuth = LocalAuthentication();
      authenticated = await localAuth.authenticateWithBiometrics(
        localizedReason: 'Limited attempts'
      );
    } on PlatformException catch (e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 24,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 8,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2
              )
            ),
            child: Center(
              child: Text(
                "Jack",
                style: TextStyle(
                  fontSize: 42,
                  color: Colors.black,
                  fontFamily: "Montserrat"
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _authenticate,
        child: Icon(Icons.fingerprint),
      ),
    );
  }
}