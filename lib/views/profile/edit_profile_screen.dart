import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:superstore_app/custom_widgets/buttons.dart';
import 'package:superstore_app/utils/styles/colors.dart';
import 'package:superstore_app/utils/styles/text_styles.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String userName = "";
  String userPhone = "";
  String address = "";
  bool isLoading = false;
  ImagePicker _picker = ImagePicker();
  XFile? selectedImage;
  Future<void> uploadImage(ImageSource source) async {
    var pickedImage = await _picker.pickImage(source: source);
    setState(() {
      selectedImage = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.red,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("Edit Profile", style: AppTextStyles.APPBAR_HEADING_STYLE),
      ),
      body: Column(
        children: [
          Divider(thickness: 0.7, color: Colors.red),
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: double.infinity,
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection("customers").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.red, width: 1)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: userData["image"] != null
                                    ? Image.network(
                                        userData['image'],
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        File(selectedImage!.path),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(width: 30),
                          Column(
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                                  color: Colors.purple,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    uploadImage(ImageSource.gallery);
                                  },
                                  icon: Icon(
                                    Icons.photo,
                                    color: ColorPallet.PRIMARY_WHITE,
                                    size: 20,
                                  ),
                                ),
                              ),
                              SizedBox(height: 05),
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.only(bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5)),
                                  color: Colors.purple,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    uploadImage(ImageSource.camera);
                                  },
                                  icon: Icon(Icons.camera_alt, color: ColorPallet.PRIMARY_WHITE, size: 20),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 40),
                      Text("Your Name"),
                      TextFormField(
                        initialValue: userData['customerName'],
                        onChanged: (v) {
                          setState(() {
                            userName = v;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      Text("Your Phone"),
                      TextFormField(
                        initialValue: userData['phone'],
                        onChanged: (v) {
                          setState(() {
                            userPhone = v;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      // Text("Your Address"),
                      // TextFormField(
                      //   initialValue: userData['address'],
                      //   onChanged: (v) {
                      //     setState(() {
                      //       address = v;
                      //     });
                      //   },
                      // ),
                    ],
                  ),
                );
              },
            ),
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: PrimaryButton(
                    onTap: () async {
                      String imageUrl = "";
                      FirebaseStorage fs = FirebaseStorage.instance;
                      Reference ref = await fs.ref().child(DateTime.now().millisecondsSinceEpoch.toString());
                      await ref.putFile(File(selectedImage!.path));
                      imageUrl = await ref.getDownloadURL();
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        FirebaseFirestore.instance.collection("customers").doc(FirebaseAuth.instance.currentUser!.uid).update({
                          "image": imageUrl,
                          "phone": userPhone,
                          "customerName": userName,
                        });
                        setState(() {
                          isLoading = false;
                        });
                        await ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Changes Save Successfully")));
                        Navigator.of(context).pop();
                      } catch (e) {
                        setState(() {
                          isLoading = false;
                        });
                        print(e);
                      }
                    },
                    title: "Save Changes",
                  ),
                )
        ],
      ),
    );
  }
}
