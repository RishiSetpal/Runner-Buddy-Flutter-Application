import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String firstName;
  String lastName;
  String phoneNumber;
  String address;

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "continue",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                // TODO: Specify your own method
                // print(firstName);
                // print(lastName);
                // print(phoneNumber);
                // print(address);
                print(firstName);
                print(lastName);
                print(address);
                print(phoneNumber);
                _addUserName(firstName: firstName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your phone address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        // If  you are using latest version of flutter then label text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  Future<void> _addUserName({firstName}) async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    final user = (_auth.currentUser);
    print("Logged in user is : " + user.email);
    // print(firstName);

    _fireStore
        .collection('users')
        .doc(user.email)
        .set({
          'email': user.email,
          'fName': firstName,
          'lName': lastName,
          'pNumber': phoneNumber,
          'ad': address,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
// if (!user.emailVerified) {
    //   await user.sendEmailVerification();
    //   Scaffold.of(context).showSnackBar(SnackBar(
    //     content: Text("You need to verify account through mail first"),
    //   ));
    // }
    {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(user.email),
      ));
      Navigator.pushNamed(context, OtpScreen.routeName);
    }
  }
}

//
// FirebaseAuth _auth = FirebaseAuth.instance;
// final user = (_auth.currentUser);
//
// db=firebase
// var docRef = db.collection("users").doc(email);
//
// docRef.get().then(function(doc) {
//   if (doc.exists) {
//     print("Document data:", doc.data());
//   } else {
//     // doc.data() will be undefined in this case
//     console.log("No such document!");
//   }
// }).catch(function(error) {
//   console.log("Error getting document:", error);
// });
//
//
//
//
// CollectionReference users = FirebaseFirestore.instance.collection('users');
//
// return FutureBuilder<DocumentSnapshot>(
// future: users.doc(currentuser's email).get(),
// builder:
// (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//
// if (snapshot.hasError) {
// return Text("Something went wrong");
// }
//
// if (snapshot.connectionState == ConnectionState.done) {
// Map<String, dynamic> data = snapshot.data.data();
// return Text("Full Name: ${data['firstName']} ${data['lastName']}");
// }
//
// return Text("loading");
// },
// );

//FirebaseFirestore.instance
//     .collection('users')
//     .doc(email)
//     .get()
//     .then((QuerySnapshot querySnapshot) => {
//         querySnapshot.docs.forEach((doc) {
//             print(doc["key used in firestore"]);
//         });
//     });
