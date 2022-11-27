import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 20,
        onPressed: () {
          _showDialog(context);
        },
        child: Icon(
          FontAwesomeIcons.pen,
          color: Colors.black,
        ),
      ),
      body: StreamBuilder(
        stream: firestoreDb,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          return ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 3,
              );
            },
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(snapshot.data!.docs[index]["title"]),
                    Text(snapshot.data!.docs[index]["description"]),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
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
              const Text("please fill the form"),
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

class Textfield extends StatelessWidget {
  const Textfield({Key? key, required this.controller, required this.strig})
      : super(key: key);

  final TextEditingController controller;
  final String strig;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: TextField(
      autocorrect: true,
      autofocus: true,
      decoration: InputDecoration(
        labelText: strig,
      ),
      controller: controller,
    ));
  }
}
