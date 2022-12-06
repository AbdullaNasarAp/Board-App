import 'package:boardapp/view/core/color.dart';
import 'package:boardapp/view/settings/setting_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class TodoProvider with ChangeNotifier {
  FirebaseAuth firebase = FirebaseAuth.instance;

  void addTask(String todo) {
    if (todo.isEmpty) {
      return;
    } else {
      FirebaseFirestore.instance
          .collection(
        "${firebase.currentUser!.email}",
      )
          .add({
        "title": todo,
      });
      notifyListeners();
    }
  }

  deleteTask(String id) {
    FirebaseFirestore.instance
        .collection("${firebase.currentUser!.email}")
        .doc(id)
        .delete();
    notifyListeners();
  }

  void showDeleteDialog(String id, context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: const Text('Do you want to remove it?'),
          title: const Text('Remove?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel')),
            TextButton(
              onPressed: () {
                deleteTask(id);
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(redColor),
              ),
              child: const Text('Delete'),
            )
          ],
        );
      },
    );
    notifyListeners();
  }

  void goToSettings(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
    notifyListeners();
  }
}
