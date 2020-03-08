import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:async';
import 'package:ssh/ssh.dart';

import 'package:jack/pages/home.dart';
import 'package:jack/utils/details.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int counter = 0;

  Future _authenticate() async{
    bool authenticated = false;
    try {
      var localAuth = LocalAuthentication();
      authenticated = await localAuth.authenticateWithBiometrics(
        localizedReason: "Authenticate user for Dewansh's MacBook Air"
      );
    } on PlatformException catch (e){
      print(e);
    }
    if(authenticated){
      var client = new SSHClient(
        host: host,
        port: 22,
        username: username,
        passwordOrKey: password,
      );
      await client.connect();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(client: client,)
        )
      );
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