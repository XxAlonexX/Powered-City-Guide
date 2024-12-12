import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' show log;
import 'core/app_theme.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const PoweredCityGuideApp());
}

class PoweredCityGuideApp extends StatefulWidget {
  const PoweredCityGuideApp({Key? key}) : super(key: key);

  @override
  _PoweredCityGuideAppState createState() => _PoweredCityGuideAppState();
}

class _PoweredCityGuideAppState extends State<PoweredCityGuideApp> {
  bool _isFirstLaunch = true;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final firstLaunch = prefs.getBool('first_launch');
      
      log('First launch check: $firstLaunch');
      
      setState(() {
        _isFirstLaunch = firstLaunch ?? true;
      });
    } catch (e) {
      log('Error checking first launch: $e');
      setState(() {
        _isFirstLaunch = true;
      });
    }
  }

  void navigateXxAloneXx(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('first_launch', false);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    log('Building app with _isFirstLaunch: $_isFirstLaunch');
    
    return MaterialApp(
      title: 'Powered City Guide',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: _isFirstLaunch 
        ? OnboardingScreen(
            onFinish: (context) => navigateXxAloneXx(context),
          )
        : HomeScreen(),
    );
  }
}
