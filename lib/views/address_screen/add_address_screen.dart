import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:superstore_app/custom_widgets/buttons.dart';
import 'package:superstore_app/utils/styles/text_field_decoration.dart';
import 'package:superstore_app/utils/styles/text_styles.dart';

import '../../utils/styles/colors.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  bool isLoading = false;
  late String firstName;
  late String lastName;
  late String phoneNumber;
  late String countryValue;
  late String stateValue;
  late String cityValue;
  GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: ColorPallet.PRIMARY_BLACK,
        ),
        title: Text(
          "Add Address Screen",
          style: AppTextStyles.APPBAR_HEADING_STYLE,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                onSaved: (v) {
                  setState(() {
                    firstName = v.toString();
                  });
                },
                validator: (v) {
                  if (v!.isEmpty) {
                    return "First Name Must Be Filled";
                  } else {
                    return null;
                  }
                },
                decoration: inputDecoration.copyWith(
                  hintText: "First Name",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                onSaved: (v) {
                  setState(() {
                    lastName = v.toString();
                  });
                },
                validator: (v) {
                  if (v!.isEmpty) {
                    return "Last Name Must Be Filled";
                  } else {
                    return null;
                  }
                },
                decoration: inputDecoration.copyWith(
                  hintText: "Last Name",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                onSaved: (v) {
                  setState(() {
                    phoneNumber = v.toString();
                  });
                },
                validator: (v) {
                  if (v!.isEmpty) {
                    return "Phone number Must Be Filled";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
                decoration: inputDecoration.copyWith(
                  hintText: "Phone Number",
                ),
              ),
              SizedBox(height: 20),
              SelectState(
                onCountryChanged: (value) {
                  setState(() {
                    countryValue = value;
                  });
                },
                onStateChanged: (value) {
                  setState(() {
                    stateValue = value;
                  });
                },
                onCityChanged: (value) {
                  setState(() {
                    cityValue = value;
                  });
                },
              ),
              Spacer(),
              isLoading
                  ? CircularProgressIndicator()
                  : PrimaryButton(
                      onTap: () async {
                        if (_key.currentState!.validate()) {
                          _key.currentState!.save();
                          var uid = FirebaseAuth.instance.currentUser!.uid;
                          try {
                            setState(() {
                              isLoading = true;
                            });
                            await FirebaseFirestore.instance.collection("users").doc(uid).update({
                              "address": countryValue + " " + stateValue + " " + cityValue,
                              "customerName": firstName + " " + lastName,
                              "phone": phoneNumber,
                            });
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.of(context).pop();
                          } catch (e) {
                            setState(() {
                              isLoading = false;
                            });
                            print(e);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Fill All Requirements")));
                        }
                      },
                      title: "Add New Address",
                    ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
