import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:instagram_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter/responsive/responsive_layout_screen.dart';
import 'package:instagram_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_flutter/screens/login_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _image; // global image
  bool _isLoading = false;

  @override // we need to clear off these widgets when our controllers get disposed
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im =
        await pickImage(ImageSource.gallery); // picking image from our files
    setState(() {
      _image = im; // im =>
    });
  }

  void signUpUser() async {
    // new signUpUser function declared not the same with one used in auth_methods.dart
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        // reusing the function(signUpUser used in auth_methods.dart)
        email: _emailController
            .text, // equating email signed in in auth_methods.dart to email put by the user
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);

    // if string returned is not success, show the snackBar
    if (res != "success") { // if not successful to showSnackBar
      showSnackBar(res, context);
    } else { // if successful to show the responsive layout after sign up
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
    
    setState(() {
      _isLoading = false;
    });
  }

  void navigateLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          children: [
            Flexible(
                // to space out by including empty container
                flex: 2,
                child: Container()),

            // svg image
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              color: primaryColor,
              height: 64,
            ),

            const SizedBox(
              height: 15,
            ),

            // circular image for user to upload their image

            Stack(
              // used to stack circular avatar and IconButton on top of each other[ is a built-in widget in flutter SDK which allows us to make a layer of widgets by putting them on top of each other]
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        // A circle that represents a user. Typically used with a user's profile image, or, in the absence of such an image, the user's initials.
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://thumbs.dreamstime.com/b/default-profile-picture-avatar-photo-placeholder-vector-illustration-default-profile-picture-avatar-photo-placeholder-vector-189495158.jpg'),
                      ),
                Positioned(
                  // used to  position child widgets in Stack [Positioned does exactly what it sounds like, which is it arbitrarily positioned widgets on top of each other]
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    // is a picture printed on a Material widget that reacts to touches by filling with color (ink)
                    onPressed: selectImage,
                    icon: const Icon(
                      Icons.add_a_photo, // icon for adding photo
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),
            // username field
            TextFieldInput(
              textEditingController: _usernameController,
              hintText: 'Enter your username',
              textInputType: TextInputType.text,
            ),

            const SizedBox(
              height: 15,
            ),

            // email input field
            TextFieldInput(
              textEditingController: _emailController,
              hintText: 'Enter your email',
              textInputType: TextInputType.emailAddress,
            ),

            const SizedBox(
              height: 12,
            ),
            // password input field
            TextFieldInput(
              textEditingController: _passwordController,
              hintText: 'Enter your password',
              textInputType: TextInputType.text,
              isPass: true,
            ),

            const SizedBox(
              height: 15,
            ),

            TextFieldInput(
              textEditingController: _bioController,
              hintText: 'Enter your bio',
              textInputType: TextInputType.text,
            ),

            const SizedBox(height: 12),

            // Login button

            InkWell(
              onTap: signUpUser,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                ),
                child: _isLoading
                    ? const Center(
                        // if it is loading we center it with CircularProgressIndicator
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text('Sign Up'),
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            // asking if one have an account

            Flexible(
              // brings the in_between space
              flex: 2,
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: navigateLogin,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(" Already have an account?"),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),                
              ],
            )
          ],
        ),
      ),
    ));
  }
}
