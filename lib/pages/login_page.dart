import 'package:flutter/material.dart';
import 'package:kchat/services/auth/auth_service.dart';
import 'package:kchat/components/my_button.dart';
import 'package:kchat/components/my_textfield.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  void Function()? onTap;
  LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // sign user in methord
  void signUserIn() async {
    // auth service from
    final authService = AuthService();
    // show loading circle

    try {
      await authService.signInWithEmailPassword(
        emailController.text,
        passwordController.text,
      );

      // pop the loading circle
      // ignore: use_build_context_synchronously
      // Navigator.pop(context);
    } catch (e) {
      // pop the loading circle
      // ignore: use_build_context_synchronously
      // Navigator.pop(context);

      //   if (e.code == 'user-not-found') {
      //     wrongEmailMessage();
      //   } else if (e.code == 'wrong-password') {
      //     wrongPasswordMessage();
      //   } else if (e.code == 'invalid-credential') {
      //     wrongOtherMessage();
      //   }
      // }

      showErrorMessage(e.toString());
    }
  }

  // void wrongEmailMessage() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return const AlertDialog(
  //         title: Text("Incorrect Email"),
  //       );
  //     },
  //   );
  // }

  // void wrongPasswordMessage() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return const AlertDialog(
  //         title: Text("Incorrect Password"),
  //       );
  //     },
  //   );
  // }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: AlertDialog(
            title: Text(
              message.toString(),
            ),
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
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(
                  height: 30,
                ),

                //welcome back you've been missed
                Text(
                  "Welcome back you've been missed!",
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
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(
                  height: 10,
                ),

                // forget password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forget Password",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // sign in button
                MyButton(
                  onTap: signUserIn,
                  text: "Login",
                ),

                const SizedBox(
                  height: 50,
                ),

                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
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
                        "Register now",
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
