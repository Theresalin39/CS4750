import 'package:flutter/material.dart';
import 'package:my_first_flutter_project/Login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MySignUpPage extends StatefulWidget {
  const MySignUpPage({super.key, required this.title});

  final String title;

  @override
  State<MySignUpPage> createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {

  var emailController= TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 50, right: 50.0),
                child:
                OutlinedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyLoginPage(title: 'Log in',)),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(65, 65),
                    shape: const CircleBorder(),
                    side: const BorderSide(width: 2.0, color: Colors.purple),
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.purple, size: 33,),
                ),
              ),

            Container(
              margin: const EdgeInsets.all(30),
              child: const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
            ),
            Container(
              margin:  const EdgeInsets.only(left: 30, right:30, bottom:10),
              child: TextField(
                controller: emailController,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right:30, bottom:10),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top:25),
                width: 240,
                height: 50,
                child: ElevatedButton(
                  child: const Text('Sign Up'),
                    onPressed: (){
                      print(emailController.text);
                      print(passwordController);
                      
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController.text, password: passwordController.text)
                          .then((value) {
                            print("Successfully signed up!");
                            Navigator.pop(context);
                          }).catchError((error){
                            print("Failed to sign up!");
                            print(error.toString());
                          });
                    },
                )
            ),
          ],
        ),
      ),
    );
  }
}
