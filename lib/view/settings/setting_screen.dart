import 'dart:io';

import 'package:boardapp/controller/provider/auth_provider.dart';
import 'package:boardapp/controller/provider/user_detials_provider.dart';
import 'package:boardapp/view/core/color.dart';
import 'package:boardapp/view/core/space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).downloadImage();
    });
    final provider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          TextButton.icon(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                whiteColor,
              ),
            ),
            onPressed: () {
              provider.signOut(context);
              Provider.of<AuthProvider>(context, listen: false).signOut();
            },
            icon: const Icon(Icons.login_rounded),
            label: const Text('LogOut'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            hight20,
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Consumer<UserProvider>(
                  builder: (context, value, child) {
                    return CircleAvatar(
                      radius: 53,
                      child: value.image == null
                          ? value.downloadUrl.isEmpty
                              ? const CircleAvatar(
                                  radius: 50,
                                )
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    value.downloadUrl,
                                  ),
                                  radius: 50,
                                )
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(
                                File(value.image!.path),
                              ),
                            ),
                    );
                  },
                ),
                Consumer<UserProvider>(
                  builder: (context, value, child) {
                    return CircleAvatar(
                      child: InkWell(
                        onTap: () {
                          value.getImage();
                        },
                        child: const Icon(
                          Icons.photo,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            hight30,
            Text(
              'Email - ${provider.firebase.currentUser!.email}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
