import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => RegisterPage();
}

class RegisterPage extends State<Register> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
          "Register",
          style: TextStyle(
              fontSize: 42)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (Navigator.of(context).pop),
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
                decoration: InputDecoration(
                    labelText: "Name")),
            TextField(
                decoration: InputDecoration(
                    labelText: "Email")),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {
             // NavigationBar
            }, child: Text("Create Account")),
          ],
        ),
      ),
    );
  }
}