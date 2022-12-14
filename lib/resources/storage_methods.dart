import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // adding image to firebase storage

  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    // declaring
    // Create a reference to upload, download, or delete a file, or to get or update its metadata. A reference can be thought of as a pointer to a file in the cloud.
    //.child(childName) => first Value on uploadImageToStorage called String childName
    //.child(_auth.currentUser!.uid)  takes second value
    Reference ref = _storage.ref().child(childName).child(_auth.currentUser!
        .uid); // create a reference to a location lower in the tree by using the child() method on an existing reference.

    if (isPost) {
      String id = const Uuid().v1(); // generate unique id fro the post
      ref = ref.child(id); // then we can equate id with
    }
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap =
        await uploadTask; // because it is future we need to await uploadTask
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
