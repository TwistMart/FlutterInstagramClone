import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async { // ImageSource => Specifies the source where the picked image should come from.
  // to await we need async 
  final ImagePicker _imagePicker = ImagePicker();
  // pickImage will give us a future of XFile and  XFile can be null and 
  XFile? _file = await _imagePicker.pickImage(source: source); // _imagePicker.[dot notation invokes methods found in _imagePicker]
 // .pickImage picks the image from the source we mentioned

  if (_file != null) {
   
    return await _file.readAsBytes(); //  we return the file if it is not null .Uint8List method used instead using dart.io method 
  }
  print('No image selected');  // if the file has not been selected successfully
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}


class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}