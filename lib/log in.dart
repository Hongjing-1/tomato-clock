import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Email:",
                  labelStyle: TextStyle(
                    color: Color(0xFFF7E7CE),
                    fontSize: 30,
                  ),
                ),
              ),
              TextField(
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Password:",
                  labelStyle: TextStyle(
                    color: Color(0xFFF7E7CE),
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/Apppagecontroller');
                },
                child: Text(
                  'Log in',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // 新增「註冊新帳號」按鈕
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/register'); // 跳到註冊頁面
                },
                child: Text(
                  'Don’t have an account? Register Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
