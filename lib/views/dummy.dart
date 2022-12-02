import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:superstore_app/custom_widgets/buttons.dart';

class Dummy extends StatefulWidget {
  const Dummy({Key? key}) : super(key: key);

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  payment() async {
    try {
      var digest;
      String dateandtime = DateFormat("yyyyMMddHHmmss").format(DateTime.now());
      String dexpiredate = DateFormat("yyyyMMddHHmmss").format(DateTime.now().add(Duration(days: 1)));
      String tre = "T" + dateandtime;
      String pp_Amount = "10000";
      String pp_BillReference = "billRef";
      String pp_Description = "Description";
      String pp_Language = "EN";
      String pp_MerchantID = "MC51147";
      String pp_Password = "dt858c8w53";
      String pp_ReturnURL = "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction";
      String pp_ver = "1.1";
      String pp_TxnCurrency = "PKR";
      String pp_TxnDateTime = dateandtime.toString();
      String pp_TxnExpiryDateTime = dexpiredate.toString();
      String pp_TxnRefNo = tre.toString();
      String pp_TxnType = "MWALLET";
      String ppmpf_1 = "03122036440";
      String IntegeritySalt = "s5ts7u85b3";
      String and = '&';
      String superdata = IntegeritySalt +
          and +
          pp_Amount +
          and +
          pp_BillReference +
          and +
          pp_Description +
          and +
          pp_Language +
          and +
          pp_MerchantID +
          and +
          pp_Password +
          and +
          pp_ReturnURL +
          and +
          pp_TxnCurrency +
          and +
          pp_TxnDateTime +
          and +
          pp_TxnExpiryDateTime +
          and +
          pp_TxnRefNo +
          and +
          pp_TxnType +
          and +
          pp_ver +
          and +
          ppmpf_1;

      var key = utf8.encode(IntegeritySalt);
      var bytes = utf8.encode(superdata);
      var hmacSha256 = new Hmac(sha256, key);
      Digest sha256Result = hmacSha256.convert(bytes);
      var url = 'https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction';

      var response = await http.post(Uri.parse(url), body: {
        "pp_Version": pp_ver,
        "pp_TxnType": pp_TxnType,
        "pp_Language": pp_Language,
        "pp_MerchantID": pp_MerchantID,
        "pp_Password": pp_Password,
        "pp_TxnRefNo": tre,
        "pp_Amount": pp_Amount,
        "pp_TxnCurrency": pp_TxnCurrency,
        "pp_TxnDateTime": dateandtime,
        "pp_BillReference": pp_BillReference,
        "pp_Description": pp_Description,
        "pp_TxnExpiryDateTime": dexpiredate,
        "pp_ReturnURL": pp_ReturnURL,
        "pp_SecureHash": sha256Result.toString(),
        "ppmpf_1": "03122036440"
        // "ppmpf_1": "4456733833993"
      });

      print("response=>");
      print(response.body);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PrimaryButton(
          title: "Jazz Cash Payment",
          onTap: () {
            payment();
          },
        ),
      ),
    );
  }
}
