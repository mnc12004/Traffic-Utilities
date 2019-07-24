import 'package:flutter/material.dart';
import 'package:trafficutilities/screens/breath_calc_screen.dart';
import 'package:trafficutilities/screens/chat_screen.dart';
import 'package:trafficutilities/screens/home_screen.dart';
import 'package:trafficutilities/screens/lams_screen.dart';
import 'package:trafficutilities/screens/login_screen.dart';
import 'package:trafficutilities/screens/my_links_screen.dart';
import 'package:trafficutilities/screens/profile_screen.dart';
import 'package:trafficutilities/screens/register_screen.dart';
import 'package:trafficutilities/screens/rego_check_screen.dart';
import 'package:trafficutilities/screens/weather_screen.dart';
import 'package:trafficutilities/screens/welcome_screen.dart';
import 'package:trafficutilities/screens/where_am_i_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      theme: ThemeData.light().copyWith(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        // Main Tools
        BreathCalcScreen.id: (context) => BreathCalcScreen(),
        //BreathResults.id: (context) => BreathResult(),
        RegoCheckScreen.id: (context) => RegoCheckScreen(),
        LAMSScreen.id: (context) => LAMSScreen(),
        // Other tools.
        WhereAmIScreen.id: (context) => WhereAmIScreen(),
        WeatherScreen.id: (context) => WeatherScreen(),
        MyLinksScreen.id: (context) => MyLinksScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        // Profile Screens
        ProfileScreen.id: (context) => ProfileScreen(),
      },
    );
  }
}
