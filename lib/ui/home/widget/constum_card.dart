import 'package:boardapp/ui/home/home.dart';
import 'package:boardapp/ui/home/widget/textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CostumCard extends StatelessWidget {
  const CostumCard({super.key, required this.snapshot, required this.index});
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    var timeToDate = DateTime.fromMillisecondsSinceEpoch(
        snapshot.data!.docs[index].data()["timestamp"].seconds * 1000);
    var dateFormatted = DateFormat("EEEE,MMM,d,y").format(timeToDate);
    var data = snapshot.data!.docs[index].data();
    var docsId = snapshot.data!.docs[index].id;
    TextEditingController nameInputController =
        TextEditingController(text: data["name"]);
    TextEditingController titleInputController =
        TextEditingController(text: data["title"]);
    TextEditingController descriptionInputController =
        TextEditingController(text: data["description"]);
    return Column(children: [
      Container(
        height: 200,
        color: Colors.yellow,
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.elliptical(100, 20),
                topLeft: Radius.elliptical(100, 20)),
          ),
          elevation: 30,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ListTile(
                  title: Text(data["title"]),
                  subtitle: Text(data["description"]),
                  leading: CircleAvatar(
                    radius: 32,
                    child: Text(data["title"].toString()[0]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Author :${data["name"]}",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300),
                          ),
                          Text(
                            dateFormatted,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () async {
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
                                            "Please Update the form ",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Textfield(
                                              controller: nameInputController,
                                              strig: "Your Name*"),
                                          Textfield(
                                              controller: titleInputController,
                                              strig: "Title*"),
                                          Textfield(
                                              controller:
                                                  descriptionInputController,
                                              strig: "Description*"),
                                        ],
                                      ),
                                      actions: [
                                        RawMaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          fillColor: Colors.black,
                                          onPressed: () {
                                            nameInputController.clear();
                                            titleInputController.clear();
                                            descriptionInputController.clear();

                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "cancel",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        RawMaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          fillColor: Colors.black,
                                          onPressed: () {
                                            if (nameInputController
                                                    .text.isNotEmpty &&
                                                titleInputController
                                                    .text.isNotEmpty &&
                                                descriptionInputController
                                                    .text.isNotEmpty) {
                                              FirebaseFirestore.instance
                                                  .collection("board")
                                                  .doc(docsId)
                                                  .update({
                                                "name":
                                                    nameInputController.text,
                                                "title":
                                                    titleInputController.text,
                                                "description":
                                                    descriptionInputController
                                                        .text,
                                                "timestamp": DateTime.now(),
                                              }).then((response) {
                                                Navigator.pop(context);
                                              });
                                            }
                                          },
                                          child: const Text(
                                            "Update",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                final snackBar = SnackBar(
                                    duration: const Duration(milliseconds: 400),
                                    content: Text("  ${data["name"]} Updated"));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              icon: const Icon(FontAwesomeIcons.edit)),
                          IconButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection("board")
                                    .doc(docsId)
                                    .delete();
                                final snackBar = SnackBar(
                                    duration: const Duration(milliseconds: 400),
                                    content: Text("delete ${data["name"]}"));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              icon: const Icon(FontAwesomeIcons.solidTrashCan))
                        ],
                      )
                    ],
                  ),
                ),
              ]),
        ),
      ),
    ]);
  }
}
