import 'package:flutter/material.dart';
import 'package:my_first_flutter_project/main.dart';
import 'package:my_first_flutter_project/second_page.dart';
import 'package:my_first_flutter_project/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 30),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyHomePage(title: 'Home'),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(65, 65),
                    shape: const CircleBorder(),
                    side: const BorderSide(width: 2.0, color: Colors.green),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.green,
                    size: 33,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Log in',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 240,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text)
                          .then((value) {
                          print("Login successfully");
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MySecondPage(title: 'learning numbers'),
                          ),
                        );
                      }).catchError((error) {
                        print("Failed to login");
                        print(error.toString());
                      });
                    },
                    child: const Text("Log in"),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: 240,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MySignUpPage(title: 'Sign Up'),
                        ),
                      );
                    },
                    child: const Text("Sign Up"),
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
