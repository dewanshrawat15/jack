import 'package:flutter/material.dart';
import 'pages/auth.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF7E57C2),
        accentColor: Color(0xFF7E57C2)
      ),
      home: AuthScreen(),
    )
  );
}