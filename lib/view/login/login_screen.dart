import 'package:boardapp/controller/provider/auth_provider.dart';
import 'package:boardapp/view/core/color.dart';
import 'package:boardapp/view/core/space.dart';
import 'package:boardapp/view/core/style.dart';
import 'package:boardapp/view/home/home_screen.dart';
import 'package:boardapp/view/register/register_screen.dart';
import 'package:boardapp/view/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final TextEditingController email = TextEditingController();
final TextEditingController password = TextEditingController();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    final provider = Provider.of<AuthProvider>(context);

    return StreamBuilder(
      stream: provider.stream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomeScreen();
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Login Account"),
          ),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/image/fire.png",
                        height: 150,
                      ),
                      const Text(
                        "Firebase",
                        style: textStyel1Bold,
                      ),
                      const Text(
                        'Authentication',
                        style: textStyel1,
                      ),
                      hight30,
                      TextFormFieldCustom(
                        keyboardType: TextInputType.emailAddress,
                        controller: email,
                        labelText: 'E-mail',
                      ),
                      hight10,
                      Consumer<AuthProvider>(
                        builder: (context, value, child) {
                          return TextFormFieldCustom(
                            keyboardType: TextInputType.visiblePassword,
                            controller: password,
                            labelText: 'Password',
                            obscureText: value.obscureText,
                            suffix: IconButton(
                              onPressed: () {
                                value.toggle();
                              },
                              icon: Icon(
                                value.obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: value.obscureText
                                    ? Colors.blue
                                    : Colors.white,
                              ),
                              splashRadius: 20,
                            ),
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ));
                            },
                            child: const Text(
                              "Register",
                              style: textStyel,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot Password?",
                              style: textStyel,
                            ),
                          ),
                        ],
                      ),
                      if (provider.isLoading)
                        const CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      if (!provider.isLoading)
                        SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(
                            onPressed: () {
                              provider.signInPressed(
                                email.text,
                                password.text,
                                context,
                              );
                              email.clear();
                              password.clear();
                            },
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(
                                0,
                              ),
                            ),
                            child: const Text('Sing In'),
                          ),
                        ),
                      hight10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: (size / 2) - 40,
                            child: const Divider(),
                          ),
                          const Text(
                            'Or',
                            style: textStyel,
                          ),
                          SizedBox(
                            width: (size / 2) - 40,
                            child: const Divider(),
                          ),
                        ],
                      ),
                      hight10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              provider.googleSignInPressed(context);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.grey[200],
                              ),
                              foregroundColor: MaterialStateProperty.all(
                                blackColor,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/image/google.png',
                                    width: 30,
                                  ),
                                  hight10,
                                  const Text(
                                    'Sign in with Google',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              provider.appleSignInPressed(context);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.black,
                              ),
                              foregroundColor: MaterialStateProperty.all(
                                Colors.grey,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/image/apple.png',
                                    width: 50,
                                  ),
                                  hight10,
                                  const Text(
                                    'Sign in with Apple',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
