import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart'; // helps in firebase initialization to connect our app to firebase
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter/responsive/responsive_layout_screen.dart';
import 'package:instagram_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_flutter/screens/login_screen.dart';
import 'package:instagram_flutter/screens/signup_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //WidgetsFlutterBinding  is used to make sure that the flutter widget has been initialized
  if (kIsWeb) {
    await Firebase.initializeApp(
      // initializing our app to firebase
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAlyhp6RjlkRGS_0y_7lYZIpE2UiWtMpIU',
        appId: '1:498189891921:web:a0b37db0132f7bae89fb70',
        messagingSenderId: '498189891921',
        projectId: 'instagram-clone-11dd8',
        storageBucket: "instagram-clone-11dd8.appspot.com",
      ),
    );
  }

  //  else {
  //   await Firebase.initializeApp();
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // removes the debug banner
        title: 'instagram clone',
        theme: ThemeData.dark().copyWith(
          //This method (copyWith) takes all the properties(which need to change) and their corresponding values and returns new object with your desired properties.
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        // home: const ResponsiveLayout(
        //   mobileScreenLayout: MobileScreenLayout(),
        //   webScreenLayout: WebScreenLayout(),
        // ),
        home: StreamBuilder(
          // firebase provides three methods for user sign in out and sign out state i.e notifying our that user has signed in or signed out        // stream: FirebaseAuth.instance.userChanges(), // Notifies about changes to any user updates. This is a superset of both [authStateChanges] and [idTokenChanges]. It provides events on all user changes, such as when credentials are linked, unlinked and when updates to the user profile are made. The purpose of this Stream is for listening to realtime updates to the user state (signed-in, signed-out, different user & token refresh) without manually having to call [reload] and then rehydrating changes to your application.
          // stream: FirebaseAuth.instance.idTokenChanges(), // This Notifies about changes to the user's sign-in state (such as sign-in or sign-out) and also token refresh events.
          stream: FirebaseAuth.instance
              .authStateChanges(), // Notifies about changes to the user's sign-in state (such as sign-in or sign-out).
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // check if our connection has been made
              if (snapshot.hasData) {
                // check if our snapshot if it is active if has any data or not
                return const ResponsiveLayout(
                    // if connections has been made and snapshot has data we are going to return a responsive layout.
                    mobileScreenLayout: MobileScreenLayout(),
                    webScreenLayout: WebScreenLayout());
              } else if (snapshot.hasError) {
                // if snapshot has not data or error
                return Center(
                  child: Text(
                      ' ${snapshot.error}'), // we display/ return the error in our snapshot
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              // if connection is still loading i.e has not been made yet
              return const Center(
                child: CircularProgressIndicator(
                  // show/return the circular progress bar
                  color: primaryColor,
                ),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
