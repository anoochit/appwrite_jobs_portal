import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:job_portal/const.dart';
import 'package:job_portal/utils/utils.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    appwriteService.getSession().then((session) {
      if ((session != null) && (session.current)) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 64.0),
                    Text(
                      "Welcome back to\nAppwrite Jobs",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                      "Let's sign in.",
                      style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(height: 64.0),

                    // form
                    TextFormField(
                      controller: userNameTextEditingController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'E-Mail',
                      ),
                      validator: (value) {
                        if (!value!.isValidEmail()) {
                          return 'Please enter email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: passwordTextEditingController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

                    // login button
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 60,
                      child: ElevatedButton(
                        child: const Text("Login"),
                        onPressed: () async {
                          // login
                          if (formKey.currentState!.validate()) {
                            // login
                            session = await appwriteService.login(
                              email: userNameTextEditingController.text,
                              password: passwordTextEditingController.text,
                            );
                            // check session
                            if ((session != null)) {
                              log("login");
                              Navigator.pushReplacementNamed(context, '/home');
                            } else {
                              log("cannot login");
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text('Cannot login'),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    // footer
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            child: const Text(
                              "Anonymous Login",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              // anonymous login
                              session = await appwriteService.anonymousLogin();
                              if (session!.current) {
                                log("login");
                                Navigator.pushReplacementNamed(context, '/home');
                              } else {
                                log("cannot login");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text('Cannot login'),
                                  ),
                                );
                              }
                            },
                          ),
                          const Text(
                            ".",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            child: const Text(
                              "Signup",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              // bavigate to signup page
                              Navigator.pushNamed(context, '/signup');
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
