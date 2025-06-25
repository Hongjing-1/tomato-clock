import 'package:flutter/material.dart';
import 'home.dart';
import 'Register.dart';
import 'log in.dart';
import 'HomePage.dart';

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
          '/register':(context)=>Home2(),
           '/log in':(context)=>login(),
          '/HomePage':(context)=>Homepage()
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: home()
    );
  }
}
