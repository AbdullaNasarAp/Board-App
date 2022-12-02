import 'package:boardapp/controller/const/constant.dart';
import 'package:boardapp/controller/provider/auth_provider.dart';
import 'package:boardapp/ui/home/home.dart';
import 'package:boardapp/ui/home/widget/textfield.dart';
import 'package:boardapp/ui/login/login.dart';
import 'package:boardapp/ui/login/widgets/finalcontainer.dart';
import 'package:boardapp/ui/login/widgets/formwidge.dart';
import 'package:boardapp/ui/register/widget/bottonbottum.dart';
import 'package:boardapp/ui/register/widget/buttonsign.dart';
import 'package:boardapp/ui/register/widget/field.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final TextEditingController email = TextEditingController();
final TextEditingController password = TextEditingController();

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final authprovider = context.watch<AuthProvider>();

    // final authProvider = Provider.of<AuthenticateProvider>(context,listen: false);
    return StreamBuilder<User?>(
      stream: authprovider.user(),
      builder: (context, user) {
        if (user.hasData) {
          return const BoardHome();
        }
        var sizedBox = const SizedBox(
          height: 20,
        );
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/image/fire.png',
                      height: 200,
                    ),
                    const Text(
                      'Register',
                    ),
                    sizedBox,
                    TextForm(
                        hinttext: "Email", controllerr: email, true1: false),
                    sizedBox,
                    TextForm(
                        hinttext: "Password",
                        controllerr: password,
                        true1: true),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginScreen();
                                },
                              ),
                            );
                          },
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                    if (authprovider.loading)
                      const CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    if (!authprovider.loading)
                      SigninButton(
                        onPressed: () {
                          signUp(authprovider, context);
                        },
                        text: 'Sign up',
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            googleSignup(authprovider, context);
                          },
                          child: Container1(
                            text1: "Sign in with Google",
                            image: "assets/image/google.png",
                            size: size,
                            fontsize1: 12,
                            fontweight1: FontWeight.w500,
                            color1: const Color.fromARGB(255, 66, 87, 98),
                            colors: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            appleSignup(authprovider, context);
                          },
                          child: Container1(
                            text1: "Sign in with Apple",
                            image: "assets/image/apple.png",
                            size: size,
                            fontsize1: 12,
                            fontweight1: FontWeight.w500,
                            color1: const Color.fromARGB(255, 66, 87, 98),
                            colors: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void signUp(AuthProvider provider, context) async {
    final message = await provider.signUp(email.text, password.text);
    if (message == '') {
      return;
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: kRed),
          ),
          backgroundColor: kBlack,
        ),
      );
    }
  }

  void googleSignup(AuthProvider provider, context) async {
    final message = await provider.googleSignup();
    if (message == '') {
      return;
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: kRed),
          ),
          backgroundColor: kBlack,
        ),
      );
    }
  }

  void appleSignup(AuthProvider provider, context) async {
    final message = await provider.appleSignup();
    if (message == '') {
      return;
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: kRed),
          ),
          backgroundColor: kBlack,
        ),
      );
    }
  }
}
