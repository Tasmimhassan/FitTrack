//Youtube added.
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:health_tracker/shared/services/user_provider.dart';
import 'package:health_tracker/ui/widgets/text_box.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:percent_indicator/percent_indicator.dart';



class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  // User
 final currentUser = FirebaseAuth.instance.currentUser!;

  // All Users
  //final usersCollection = FirebaseFirestore.instance.collection("Users");

  // Edit Field
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text("Edit $field",
              style: const TextStyle(color: Colors.black),
            ),
            content: TextField(
              autofocus: true,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Enter new $field",
                hintStyle: const TextStyle(color: Colors.black),
              ),
              onChanged: (value) {
                newValue = value;
              },
            ),
            actions: [
              // Cancel Button
              TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => Navigator.of(context).pop(newValue),
              ),
              TextButton(
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => Navigator.of(context).pop(newValue),
              ),

            ],
          ),
    );

   // Update in the firestore
   //  if (newValue
   //      .trim()
   //      .length > 0) {
   //    await usersCollection.doc(currentUser.email).update({field: newValue});
   //  }
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.getUser;

    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text("Profile"),
          //backgroundColor: Colors.grey[900],

        ),


        body:
        ListView(
          padding: const EdgeInsets.all(16.0),
          // child: Column(
          // children: [
          //  Row(
          children: [
            const SizedBox(height: 50),

            CircularPercentIndicator(
              radius: 50,
              lineWidth: 3,
              progressColor: const Color.fromARGB(255, 255, 108, 0),
              percent: 0.7,
              backgroundColor: Colors.transparent,
              animation: true,
              center: SizedBox(
                height: 80,
                width: 80,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user.photoUrl),
                  backgroundColor: Colors.red,
                ),
              ),
            ),

            //Profile Pic
            const Icon(
              Icons.person,
              size: 72,
            ),


            //User_Email
            Text(
              currentUser.email!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[700]),
            ),


            // UserDetails
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text('My Details',
                  style: TextStyle(color: Colors.grey[600])
              ),
            ),

            //UserName
            MyTextBox(text: 'Asif',
              sectionName: 'username',
              onPressed: () => editField('username'),
            ),

            //BIO
            MyTextBox(text: 'Empty bio',
              sectionName: 'bio',
              onPressed: () => editField('bio'),
            ),

            const SizedBox(height: 25),

            //User Posts
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('My Posts',
                  style: TextStyle(color: Colors.grey[600])
              ),
            ),
          ],

        )
    );
  }
}