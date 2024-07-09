import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/page/users/main_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(title: const Text("Error")),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(title: const Text("Register")),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Email", style: TextStyle(fontSize: 20)),
                          TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Please input the email."),
                              EmailValidator(
                                  errorText:
                                      "Email is not in the correct form.")
                            ]).call,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (email) {
                              _email = email!;
                            },
                          ),
                          const SizedBox(height: 15),
                          const Text("Password",
                              style: TextStyle(fontSize: 20)),
                          TextFormField(
                            obscureText: true,
                            onSaved: (password) {
                              _password = password!;
                            },
                          ),
                          SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  child: const Text(
                                    "REGISTER",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!
                                          .save(); // invoke all input onSaved function
                                      try {
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                                email: _email,
                                                password: _password)
                                            .then((value) {
                                          Fluttertoast.showToast(
                                              msg: "New user is created.",
                                              gravity: ToastGravity.CENTER);

                                          _formKey.currentState!.reset();
                                          // ignore: use_build_context_synchronously
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const MainLoginScreen();
                                          }));
                                        });
                                      } on FirebaseAuthException catch (e) {
                                        late String message;
                                        if (e.code == 'email-already-in-use') {
                                          message = "มีอีเมลนี้ในระบบแล้ว";
                                        } else if (e.code == 'weak-password') {
                                          message =
                                              "รหัสผ่านต้องมีความยาว 6 ตัวอักษรขึ้นไป";
                                        } else {
                                          message = e.message!;
                                        }
                                        Fluttertoast.showToast(
                                            msg: message,
                                            gravity: ToastGravity.CENTER);
                                      }
                                    }
                                  }))
                        ],
                      ),
                    )),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
