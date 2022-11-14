import 'package:fhe_template/core.dart';
import 'package:fhe_template/setup.dart';
import 'package:fhe_template/state_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() async {
  await initialize();

  Widget mainView = const HomeView();
  if (FirebaseAuth.instance.currentUser != null) {
    mainView = Container();
  }

  runApp(
    MaterialApp(
      navigatorKey: Get.navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: mainView,
    ),
  );
}
