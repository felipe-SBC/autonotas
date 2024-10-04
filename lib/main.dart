import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/login.dart';
import 'pages/aluno.dart';

void main() {
  runApp( MaterialApp(
    initialRoute: "/home",
    routes: {
      "/home": (context) => HomePage(),
      "/login": (context) => Login(),
      "/perfil": (context) => Aluno(),
    },
  ));
}
