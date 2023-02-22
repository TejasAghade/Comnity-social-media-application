// ignore_for_file: prefer_const_constructors

import 'package:comnity/firebase_options.dart';
import 'package:comnity/providers/user_provider.dart';
import 'package:comnity/responsive/mobile_screen_layout.dart';
import 'package:comnity/responsive/responsive_screen_layout.dart';
import 'package:comnity/responsive/web_screen_layout.dart';
import 'package:comnity/screens/admin_page.dart';
import 'package:comnity/screens/feed_screen.dart';
import 'package:comnity/utils/colors.dart';
import 'package:comnity/utils/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:comnity/screens/login_screen.dart';
import 'package:comnity/screens/otp_verification_screen.dart';
import 'package:comnity/screens/signup_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Comnity",

        // setting session or persiste auth state
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (isAdminGlobal) {
              return const AdminPage();
            }
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }

            return LoginPage();
          },
        ),
        routes: {
          '/signup': (context) => SignupPage(),
          '/otp': (context) => OtpVerification(),
          '/login': (context) => LoginPage(),
          '/feed': (context) => FeedScreen(),
        },
      ),
    );
  }
}
