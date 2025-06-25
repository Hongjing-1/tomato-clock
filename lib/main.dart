import 'package:flutter/material.dart';
import 'Clockpage.dart';
import 'home.dart';
import 'Register.dart';
import 'log in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes:{
          '/register':(context)=>Register(),
           '/Log in':(context)=>login(),
          '/home':(context)=>home(),
          '/login':(context)=>ClockPage()
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: home()
    );
  }
}



