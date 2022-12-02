import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:superstore_app/views/auth/sign_in_screen.dart';

import '../utils/functions/functions.dart';
import '../views/custom_bottom_navigation_bar.dart';

class AuthServices {
  static signUp(
      {BuildContext? context, String? email, String? password, String? fullName, String? image, File? selectedImage}) async {
    try {
      var _auth = FirebaseAuth.instance;
      EasyLoading.show(status: "Please Wait");
      _auth.createUserWithEmailAndPassword(email: email!, password: password!).then((value) async {
        FirebaseStorage fs = FirebaseStorage.instance;
        Reference ref = await fs.ref().child(DateTime.now().millisecondsSinceEpoch.toString());
        await ref.putFile(File(selectedImage!.path)).then((v) async {
          image = await v.ref.getDownloadURL();
        });
        FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set({
          "uid": FirebaseAuth.instance.currentUser!.uid,
          "userName": fullName,
          "email": email,
          "address": "",
          "phone": "",
          "image": image,
          "isSupplier": false,
        });
        EasyLoading.dismiss();
        await navigateToPageWithPush(context!, CustomBottomNavigation());
      });
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
      EasyLoading.dismiss();
    }
  }

  static signIn(BuildContext context, String email, String password) {
    try {
      var _auth = FirebaseAuth.instance;
      EasyLoading.show(status: "Please Wait");
      _auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
        navigateToPageWithPush(context, CustomBottomNavigation());
        EasyLoading.dismiss();
      });
    } catch (e) {
      print("hello");
      EasyLoading.showError(e.toString());
      EasyLoading.dismiss();
    }
  }

  static signOut(BuildContext context) async {
    var _auth = FirebaseAuth.instance;
    _auth.signOut().then((value) {
      navigateToPageWithPush(context, LoginScreen());
    });
  }
}
