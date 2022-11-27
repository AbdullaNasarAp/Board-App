import 'package:boardapp/controller/provider/auth_provider.dart';
import 'package:boardapp/ui/home/home.dart';
import 'package:boardapp/ui/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) => context.watch<AuthProvider>().user(),
            initialData: null),
      ],
      child: MaterialApp(
        theme: ThemeData(
            textTheme: TextTheme(
                bodyText1: GoogleFonts.montserrat(),
                bodyText2: GoogleFonts.montserrat())),
        debugShowCheckedModeBanner: false,
        home: BoardHome(),
      ),
    );
  }
}
