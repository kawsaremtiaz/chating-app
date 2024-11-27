import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kchat/services/auth/auth_service.dart';
import 'package:kchat/components/my_button.dart';
import 'package:kchat/components/my_textfield.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  void Function()? onTap;
  RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confermPasswordController = TextEditingController();

  // sign user in methord
  void signUserUp() async {
    // auth service
    final authService = AuthService();
    // show loading circle

    try {
      if (passwordController.text == confermPasswordController.text) {
        await authService.signUpWithEmailPassword(
          emailController.text,
          passwordController.text,
        );
      } else {
        // show error message
        showErrorMessage("Password don't match");
      }
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: AlertDialog(
            title: Text(message),
            titleTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                const SizedBox(
                  height: 30,
                ),
                Icon(
                  Icons.lock,
                  size: 100,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  height: 30,
                ),

                //welcome back you've been missed
                Text(
                  "Let's create an account for you!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),

                // user textfield
                MyTextfield(
                  controller: emailController,
                  hintText: "Username",
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 10,
                ),

                // password textfield
                MyTextfield(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 10,
                ),

                // conferm password
                MyTextfield(
                  controller: confermPasswordController,
                  hintText: "Conterm Password",
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                ),

                const SizedBox(
                  height: 25,
                ),

                // sign in button
                MyButton(
                  onTap: signUserUp,
                  text: "Sign Up",
                ),

                const SizedBox(
                  height: 50,
                ),

                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already register?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "SignIn",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
