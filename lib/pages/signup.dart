import 'package:flutter/material.dart';
import 'package:job_portal/const.dart';
import 'package:job_portal/utils/utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController displayNameTextEditingController = TextEditingController();
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  final formKey = GlobalKey<FormState>();

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
                    InkWell(
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 32.0,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                      "Join\nAppwrite Jobs",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                      "Create account.",
                      style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(height: 64.0),

                    // form
                    TextFormField(
                      controller: displayNameTextEditingController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: userNameTextEditingController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'E-Mail',
                      ),
                      validator: (value) {
                        if (!value!.isValidEmail() || value.isEmpty) {
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
                        child: const Text("SignUp"),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            var result = await appwriteService.signUp(
                              name: displayNameTextEditingController.text,
                              email: userNameTextEditingController.text,
                              password: passwordTextEditingController.text,
                            );

                            if (result) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text('Successfully signed up'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text('Cannot sign up'),
                                ),
                              );
                            }
                          }
                        },
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
