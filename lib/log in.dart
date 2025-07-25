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
      appBar: AppBar(
        title: Text('Log in'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (Navigator.of(context).pop),
        ),
      ),
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
            children: [

              TextField(
                style: TextStyle(color: Colors.red),
                decoration: InputDecoration(
                  labelText: "Email:",
                  labelStyle: TextStyle(
                    color: Color(0xFFF7E7CE),
                    fontSize: 30
                  ),
                ),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password:",
                  labelStyle: TextStyle(
                    color: Color(0xFFF7E7CE),
                    fontSize: 30
                  )
                ),

              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                  child: Text(
                      'Log in',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 30
                  ),)),

            ],
          ),
        ),
      ),
    );
  }
}
