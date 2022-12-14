import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:instagram_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter/responsive/responsive_layout_screen.dart';
import 'package:instagram_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_flutter/screens/signup_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // using _emailController and _passwordController  means our variables are private to this file and final means are immutable
  final TextEditingController _emailController = TextEditingController(); //
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false; //  setting default is loading as false

  @override // we need to clear off controllers as soon as  the widgets get disposed get disposed
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (res == 'success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      //
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      // SafeArea is basically a glorified Padding widget. If you wrap another widget with SafeArea, it adds any necessary padding needed to keep your widget from being blocked by the system status bar, notches, holes, rounded corners, and other "creative" features by manufacturers.

      child: Container(
        //convenience widget that combines common painting, positioning, and sizing of widgets, [ a container is like a box to store contents]
        padding: const EdgeInsets.symmetric(
            horizontal:
                32), // symmetric can be horizontal(means padding in horizontal, side by side by 32 padding) and vertical
        width: double
            .infinity, // full double.infinity means full width of the device
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // center in a row format
          children: [
            Flexible(
                //is a built-in widget in flutter which controls how a child of base flex widgets that are Row, Column, and Flex will fill the space available to it. The Expanded widget in flutter is shorthand of Flexible with the default fit of FlexFit
                // to space out by including empty container
                flex: 2,
                child: Container()),

            // svg image
            SvgPicture.asset(
              // Widget for svg pictures
              'assets/ic_instagram.svg',
              color: primaryColor,
              height: 64,
            ),

            const SizedBox(
              height: 64,
            ),

            // email input field

            TextFieldInput(
              // class TextFieldInput from login_screen.dart
              textEditingController: _emailController,
              hintText: 'Enter your email',
              textInputType: TextInputType
                  .emailAddress, // TextInputType => This gives different input types ie. emailAddress, text, phone ---
            ),

            const SizedBox(
              height: 30,
            ),
            // password input field
            TextFieldInput(
              textEditingController: _passwordController,
              hintText: 'Enter your password',
              textInputType: TextInputType.text,
              isPass: true,
            ),

            const SizedBox(
              height: 30,
            ),

            // Login button

            InkWell(
              // InkWell is a widget which makes our login button clickable[is a rectangular area in Flutter of a material that responds to touch in an application]
              onTap: loginUser,
              child: Container(
                // you material button or elevated button or text button
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
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text('Log in'),
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
                  // is a non-visual widget primarily used for detecting the user's gesture i.e button clicking
                  onTap: navigateToSignUp,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(" Don't have an account?"),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text(
                    "Sign Up",
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
