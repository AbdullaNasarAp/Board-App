import 'dart:developer';
import 'package:boardapp/controller/const/constant.dart';
import 'package:boardapp/controller/provider/auth_provider.dart';
import 'package:boardapp/ui/login/widgets/finalcontainer.dart';
import 'package:boardapp/ui/login/widgets/formwidge.dart';
import 'package:boardapp/ui/login/widgets/text1.dart';
import 'package:boardapp/ui/register/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController();
  final passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authprovider = context.watch<AuthProvider>();
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.yellow,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(19.0),
              child: Column(
                children: [
                  Image.asset(
                    "assets/image/fire.png",
                    height: 150,
                    width: 150,
                  ),
                  const Text1(
                    title: "Firebase",
                    color: Colors.grey,
                    fontsize: 40,
                    fontweight: FontWeight.bold,
                  ),
                  const Text1(
                    title: "Authentication",
                    fontsize: 35,
                    color: Colors.black,
                    fontweight: FontWeight.w400,
                  ),
                  sizedBoxHeight(20),
                  TextForm(
                    true1: false,
                    hinttext: "Email",
                    controllerr: emailController,
                  ),
                  sizedBoxHeight(20),
                  TextForm(
                    true1: true,
                    hinttext: "Password",
                    controllerr: passWordController,
                  ),
                  sizedBoxHeight(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ));
                        },
                        child: const Text1(
                            title: 'Register',
                            fontsize: 15,
                            color: Colors.blue,
                            fontweight: FontWeight.normal),
                      ),
                      InkWell(
                        onTap: () {
                          log("for");
                        },
                        child: const Text1(
                            title: 'Forgot Password ? ',
                            fontsize: 15,
                            color: Colors.blue,
                            fontweight: FontWeight.normal),
                      )
                    ],
                  ),
                  sizedBoxHeight(10),
                  if (authprovider.loading)
                    const CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  if (!authprovider.loading)
                    SizedBox(
                      width: size.width,
                      child: ElevatedButton(
                          onPressed: (() {
                            signIn(authprovider, context);
                          }),
                          child: const Text1(
                            color: Colors.white,
                            fontsize: 17,
                            fontweight: FontWeight.bold,
                            title: "Sign in",
                          )),
                    ),
                  sizedBoxHeight(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KSizedBox(size: size),
                      const Text1(
                          title: "or",
                          fontsize: 20,
                          color: Colors.black,
                          fontweight: FontWeight.normal),
                      KSizedBox(size: size),
                    ],
                  ),
                  sizedBoxHeight(
                    20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          googleSignin(authprovider, context);
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
                          appleSignin(authprovider, context);
                        },
                        child: Container1(
                          text1: "Sign in with Apple",
                          image: "assets/image/apple.png",
                          size: size,
                          fontsize1: 12,
                          fontweight1: FontWeight.w500,
                          colors: Colors.black,
                          color1: Colors.grey,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget sizedBoxHeight(double kHeight) {
    return SizedBox(
      height: kHeight,
    );
  }

  void signIn(AuthProvider provider, context) async {
    final message =
        await provider.signIn(emailController.text, passWordController.text);
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

  void googleSignin(AuthProvider provider, context) async {
    final message = await provider.googleSignin();
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

  void appleSignin(AuthProvider provider, context) async {
    final message = await provider.appleSignin();
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
