import 'package:flutter/material.dart';
import 'package:flutter_learn/page/users/login.dart';
import 'package:flutter_learn/page/users/register.dart';

class MainLoginScreen extends StatefulWidget {
  const MainLoginScreen({super.key});

  @override
  State<MainLoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<MainLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Main Login", style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromRGBO(19, 34, 87, 1.0),
          centerTitle: true,
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/fitness-logo-template.avif"),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("Register", style: TextStyle(fontSize: 20)),
                onPressed: () => {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const RegisterScreen();
                  }))
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.login),
                label: const Text("Login", style: TextStyle(fontSize: 20)),
                onPressed: () => {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const LoginScreen();
                  }))
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
