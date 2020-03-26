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

  TextEditingController ipController = TextEditingController();
  var newIP;

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

  void showAlertBox(BuildContext context){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "New IPv4",
          style: TextStyle(
            fontFamily: "Product Sans"
          ),
        ),
        content: TextField(
          autofocus: true,
          textCapitalization: TextCapitalization.none,
          controller: ipController,
          onChanged: (val){
            setState(() {
              newIP = val;
              host = newIP;
            });
          },
          onEditingComplete: (){
            setState(() {
              newIP = ipController.text;
              host = newIP;
            });
          },
          textInputAction: TextInputAction.done,
          cursorColor: Color(0xFF7E57C2),
          style: TextStyle(
            color: Color(0xFF7E57C2)
          ),
          decoration: InputDecoration(
            enabledBorder: new UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF7E57C2),
                width: 1.0
              ),
            ),
            focusedBorder: new UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF7E57C2),
                width: 1.0),
            ),
            icon: Icon(
              Icons.volume_up,
              color: Color(0xFF7E57C2)
            ),
            labelText: "New IP",
            labelStyle: TextStyle(
              color: Color(0xFF7E57C2),
              fontFamily: "Product Sans"
            ),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            highlightColor: Color(0x117E57C2),
            splashColor: Color(0x117E57C2),
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text(
              "Set IP",
              style: TextStyle(
                fontFamily: "Product Sans",
                color: Color(0xFF7E57C2)
              ),
            )
          ),
          FlatButton(
            highlightColor: Color(0x117E57C2),
            splashColor: Color(0x117E57C2),
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                fontFamily: "Product Sans",
                color: Color(0xFF7E57C2)
              ),
            )
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              CircleAvatar(
                radius: MediaQuery.of(context).size.width / 3.5,
                backgroundImage: AssetImage(
                  "assets/images/logo.JPG"
                ),
                backgroundColor: Color(0xFF7E57C2),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 16,
              ),
              Padding(
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
              SizedBox(
                height: MediaQuery.of(context).size.width / 16,
              ),
            ],
          )
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "IP Settings",
            onPressed: (){
              showAlertBox(context);
            },
            child: Icon(Icons.network_wifi),
          ),
          SizedBox(
            height: 24,
          ),
          FloatingActionButton(
            heroTag: "Fingerprint",
            onPressed: _authenticate,
            child: Icon(Icons.fingerprint),
          ),
        ],
      )
    );
  }
}