import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}


class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          child: Center(
              child: Column(
                  children: [
                    SizedBox(height: 100),
                    Text(
                        "Tomato Go",
                        style: TextStyle(
                            color: Color(0xFFCFB53B),
                            fontSize: 78,
                            fontStyle:FontStyle.normal
                        )
                    ),
                    SizedBox(height: 120),
                    ElevatedButton(
                      onPressed:() {
                        Navigator.of(context).pushNamed('/login');
                      }
                      ,
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          color: Color(0xFFCFB53B),
                          fontSize: 52,
                        ),
                      ),
                    )
                    , SizedBox(height: 200,),
                    ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed('/register');
                        }
                        ,child: Text(
                        "Register",
                        style: TextStyle(
                          color: Color(0xFFCFB53B),
                            fontSize: 52))),]
              )
          )
          ,
        ),
    );
  }
}
