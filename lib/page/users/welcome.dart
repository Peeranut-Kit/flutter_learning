import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/page/users/main_login.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
      ),
      body: Column(
        children: [
          Text(
            auth.currentUser!.email!,
            style: const TextStyle(fontSize: 25),
          ),
          ElevatedButton(
              onPressed: () {
                auth.signOut().then((value) {
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const MainLoginScreen();
                  }));
                });
              },
              child: const Text("LOG OUT"))
        ],
      ),
    );
  }
}
