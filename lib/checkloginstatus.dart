import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/login_form.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/Screens/home/home.dart';
import 'package:flutter_auth/controllers/controllerCall.dart';

class CheckLoginStatus extends StatelessWidget {
  const CheckLoginStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: Colors.white,
            body: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    controller.setloginLoading(true);

                    return GetToHomePageAsyncronously(
                      snapshot: snapshot,
                    );
                  } else {
                    return const WelcomeScreen();
                  }
                })),
      ],
    );
  }
}

Future getData(value, snapshot) async {
  if (value == true) {
    var snapshotData = await snapshot.data as User;
    controller.setUserId(snapshotData.uid);
    fetchUserModel(snapshotData.uid);
    return snapshotData.uid;
  }
}

class GetToHomePageAsyncronously extends StatelessWidget {
  final snapshot;
  const GetToHomePageAsyncronously({Key? key, required this.snapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(controller.loginLoading.value, snapshot),
      builder: (context, snapshot) {
        print("snapshot $snapshot");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const WelcomeScreen();
          }
        }
      },
    );
  }
}
