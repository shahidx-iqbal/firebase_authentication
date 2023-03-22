import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_urraan/phone_number_auth.dart';
import 'package:flutter/material.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({Key? key}) : super(key: key);

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  var firebase_auth = FirebaseAuth.instance;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 8,
          backgroundColor: Color(0xFF0099DD),
          title:
              const Center(child: Text('Email/Password Authentication')),
        ),
        body: Container(
          height: double.infinity,
          color: Color(0xff4974a5).withOpacity(0.9),
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                            padding:
                                const EdgeInsets.only(left: 15, right: 15, top: 5),
                            child: TextFormField(
                                style: const TextStyle(color: Colors.white,fontSize: 20,decoration: TextDecoration.none,
                                  decorationThickness: 0,),
                                controller: emailController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.person,color: Colors.white,size: 30,),
                                  labelStyle: TextStyle(
                                    color: Colors.white,fontSize: 15
                                  ),
                                  border: InputBorder.none,
                                  labelText: 'Email',
                                ))))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                          child: TextFormField(
                              style: const TextStyle(color: Colors.white,fontSize: 20,decoration: TextDecoration.none,
                                decorationThickness: 0,),
                              controller: passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.lock_outline,color: Colors.white,size: 30,),
                                labelStyle: TextStyle(
                                    color: Colors.white,fontSize: 15
                                ),
                                border: InputBorder.none,
                                labelText: 'Your password',
                              )))),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0xFF0099DD),
                          ),
                          child: TextButton(
                              onPressed: () {
                                String email = emailController.text.toString();
                                String password =
                                    passwordController.text.toString();
                                try {
                                  firebase_auth
                                      .createUserWithEmailAndPassword(
                                          email: email.trim(),
                                          password: password.trim())
                                      .then((UserCredential userCredential) {
                                    print('Object ${userCredential.user}');
                                  }).onError((FirebaseAuthException error,
                                          stackTrace) {
                                    if (error.code == 'email-already-in-use') {
                                      print(
                                          'Email is already in user try another email');
                                    }
                                  });
                                } catch (e) {
                                  print('Error is : ${e.toString()}');
                                  return;
                                }
                              },
                              child: const Text(
                                'Sign up With Email',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0xFF0099DD),
                          ),
                          child: TextButton(
                              onPressed: () {
                                String email = emailController.text.toString();
                                String password =
                                    passwordController.text.toString();
                                try {
                                  firebase_auth
                                      .signInWithEmailAndPassword(
                                          email: email.trim(),
                                          password: password.trim())
                                      .then((UserCredential userCredential) {
                                    print(
                                        'Object ${userCredential.user!.email}');
                                  }).onError((FirebaseAuthException error,
                                          stackTrace) {
                                    if (error.code == 'wrong-password') {
                                      print('You entered wrong password!');
                                    } else if (error.code ==
                                        'too-many-requests') {
                                      print('Too many request to sign in');
                                    }
                                  });
                                } catch (e) {
                                  print('Error is : ${e.toString()}');
                                  return;
                                }
                              },
                              child: const Text(
                                'Sign in with Email',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0xFF0099DD),
                          ),
                          child: TextButton(
                              onPressed: () {
                                try {
                                  firebase_auth
                                      .signInAnonymously()
                                      .then((value) {
                                    print(
                                        'Object ${firebase_auth.currentUser.toString()}');
                                  }).onError((FirebaseAuthException error,
                                          stackTrace) {
                                    if (error.code == 'email-already-in-use') {
                                      print(
                                          'Email is already in user try another email');
                                    }
                                  });
                                } catch (e) {
                                  print('Error is : ${e.toString()}');
                                  return;
                                }
                              },
                              child: const Text(
                                'Anonymouse',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0xFF0099DD),
                          ),
                          child: TextButton(
                              onPressed: () {
                                try {
                                  firebase_auth.signOut();
                                } catch (e) {
                                  print('Error is : ${e.toString()}');
                                  return;
                                }
                              },
                              child: const Text(
                                'Sign out',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(0xFF0099DD),
                      ),
                      child: TextButton(
                          onPressed: () {
                            try {
                              print(
                                  'Current users are: ${firebase_auth.currentUser.toString()}');
                            } catch (e) {
                              print('Error is : ${e.toString()}');
                              return;
                            }
                          },
                          child: const Text(
                            'Current User',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(0xFF0099DD),
                      ),
                      child: TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> PhoneAuthentication()));
                          },
                          child: const Text(
                            'Phone Number Authentication',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}
