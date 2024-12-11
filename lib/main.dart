import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/places_provider.dart';
import 'providers/location_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import the Firestore package

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyC-q3FqDZWy4aNqhPnVnH1Op37Q1JwDVII',
        appId: "1:928995235240:web:769a01b2197b828486f99d",
        messagingSenderId: "928995235240",
        projectId: "city-powered", 
      ),
    );
    print('Firebase initialized successfully');

    // Set Firestore settings correctly
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED, // Add this line to avoid deprecation warning
    );
  } catch (e) {
    print('Failed to initialize Firebase: $e');
    // Continue without Firebase for now
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (Firebase.apps.isEmpty) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Failed to initialize Firebase'),
          ),
        ),
      );
    } else {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => PlacesProvider()),
          ChangeNotifierProvider(create: (_) => LocationProvider()),
        ],
        child: MaterialApp(
          title: 'Powered City Guide',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
          debugShowCheckedModeBanner: false,
        ),
      );
    }
  }
}