import 'package:boardapp/controller/provider/auth_provider.dart';
import 'package:boardapp/ui/home/widget/constum_card.dart';
import 'package:boardapp/ui/home/widget/textfield.dart';
import 'package:boardapp/ui/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BoardHome extends StatefulWidget {
  const BoardHome({super.key});

  @override
  State<BoardHome> createState() => _BoardHomeState();
}

class _BoardHomeState extends State<BoardHome> {
  var firestoreDb = FirebaseFirestore.instance.collection("board").snapshots();
  TextEditingController nameInputController = TextEditingController();
  TextEditingController titleInputController = TextEditingController();
  TextEditingController descriptionInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameInputController = TextEditingController();
    titleInputController = TextEditingController();
    descriptionInputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: context.watch<AuthProvider>().user(),
        builder: (context, user) {
          if (!user.hasData) {
            return LoginScreen();
          }
          return Scaffold(
            appBar: AppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(
                    30,
                    100,
                  ),
                  bottomRight: Radius.elliptical(
                    30,
                    100,
                  ),
                ),
              ),
              title: Text(
                "Community Board",
                style: GoogleFonts.montserrat(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.yellow,
              elevation: 20,
            ),
            backgroundColor: Colors.yellow,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 70.0),
              child: FloatingActionButton(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(100, 200))),
                backgroundColor: Colors.yellow,
                elevation: 20,
                onPressed: () {
                  _showDialog(context);
                },
                child: const Icon(
                  FontAwesomeIcons.pen,
                  color: Colors.black,
                ),
              ),
            ),
            body: StreamBuilder(
              stream: firestoreDb,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 40,
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, int index) {
                      return CostumCard(
                        snapshot: snapshot,
                        index: index,
                      );
                    },
                  ),
                );
              },
            ),
          );
        });
  }

  _showDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding: const EdgeInsets.all(10),
          content: Column(
            children: [
              const Text(
                "Please Fill the Form",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Textfield(controller: nameInputController, strig: "Your Name*"),
              Textfield(controller: titleInputController, strig: "Title*"),
              Textfield(
                  controller: descriptionInputController,
                  strig: "Description*"),
            ],
          ),
          actions: [
            RawMaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              fillColor: Colors.black,
              onPressed: () {
                nameInputController.clear();
                titleInputController.clear();
                descriptionInputController.clear();

                Navigator.pop(context);
              },
              child: const Text(
                "cancel",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            RawMaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              fillColor: Colors.black,
              onPressed: () {
                if (nameInputController.text.isNotEmpty &&
                    titleInputController.text.isNotEmpty &&
                    descriptionInputController.text.isNotEmpty) {
                  FirebaseFirestore.instance.collection("board").add({
                    "name": nameInputController.text,
                    "title": titleInputController.text,
                    "description": descriptionInputController.text,
                    "timestamp": DateTime.now(),
                  }).then((response) {
                    print(response.id);
                    Navigator.pop(context);
                    nameInputController.clear();
                    titleInputController.clear();
                    descriptionInputController.clear();
                  }).catchError((error) => print(error));
                  const snackBar = SnackBar(
                      duration: Duration(milliseconds: 400),
                      content: Text("Item Added.........."));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text(
                "save",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
