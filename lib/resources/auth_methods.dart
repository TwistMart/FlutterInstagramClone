import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // we have user from firebase auth and user from pur class i.e user.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/user.dart' as model; // we use 'as models' to different our user from user from firebase auth
import 'package:instagram_flutter/resources/storage_methods.dart';

class AuthMethods { // the class is called and used in user_provider.dart used to help to go to database collection('users') and get current user, so one can easily access user details
  final FirebaseFirestore _firestore = FirebaseFirestore
      .instance; // creating an instance of Firebase class [ for storing  user information]
  final FirebaseAuth _auth = FirebaseAuth.instance; // creating an instance of FirebaseAuth class

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

// sign up user
  // When a function returns a Future , it means that it takes a while for its result to be ready, and the result will be available in the future
  // You can access the result of the Future using either of the following keywords:(await or then)
  // If a function returns a Future, it’s considered asyncrounous; you do not need to mark the body of this function with async keyword. The async keyword is necessary only if you have used the await keyword in the body of your function.

  Future<String> signUpUser({
    // return type of the function(signUpUser) is going to be future because it's asynchronous(async)
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || // validating if the email/password/username/bio is valid or not
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        // registering user in auth with email and password
        // _auth.createUserWithEmailAndPassword for sign in and for login is _auth.signInWithEmailAndPassword(email: email, password: password)

        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          // you must await if it's async
          email: email,
          password: password,
        );
        print(cred.user!.uid);

        // add the picture, posts to firebase  storage
        String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false); // take the values declared in storage_methods.dart

        // Add user to our database
        //  we put exclamation mark in [cred.user!.uid] after user because user can be returned as null
        // .collection from firebase called 'users'

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          photoUrl: photoUrl,
          following: [],
          followers: [],
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),
            );

        // without setting document in firebase to cred.user!.uid

        // await _firestore.collection('users').add({
        //   'username': username,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        // });

        res = "success";
      }
      // } on FirebaseAuthException catch (err) {
      //   if (err.code == 'invalid-email') {
      //     res = 'The email is badly formatted.';
      //   } else if (err.code == 'weak-password') {
      //     res = 'Password should be at least 6 characters';
      //   }
    } catch (err) {
      res = err.toString(); // toString method is used to return a string representation of an object.
    }
    return res;
  }

  // logging in user

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
