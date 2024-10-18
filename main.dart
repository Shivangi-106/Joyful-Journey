import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/NatureDevelopmentPage.dart';
import 'pages/LoginPage.dart';
import 'pages/LearningPage.dart';
import 'pages/CommunityPage.dart';
import 'pages/LevelSelectionPage.dart';
import 'pages/JoyfullJourneyHomePage.dart'; // Import the home page
import 'pages/SignUpPage.dart';
import 'package:audioplayers/audioplayers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Error handling during Firebase initialization
  try {
    // Provide FirebaseOptions for Web
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: "AIzaSyD6SI8y147a5TL0HOoC_EqaJc7IQ8pH49g", // Replace with your actual values
          authDomain: "joyful-journey-4f3bf.firebaseapp.com", // Make sure you use your actual Firebase project domain
          projectId: "joyful-journey-4f3bf",
          storageBucket: "joyful-journey-4f3bf.appspot.com",
          messagingSenderId: "792437430026", // Required field (ensure you put the correct one from your Firebase config)
          appId: "1:792437430026:android:d01a9c768788c1e4f3ccf3", // Your app ID
        ),
      );
    } else {
      // For Android, iOS, Firebase initializes automatically
      await Firebase.initializeApp();
    }
    runApp(const JoyfullJourneyApp()); // Start the app after successful initialization
    BackgroundMusic.loop(); // Start background music with looping
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
}

class JoyfullJourneyApp extends StatelessWidget {
  const JoyfullJourneyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Joyful Journey',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(), // Start with LoginPage
      routes: {
        '/home': (context) => JoyfullJourneyHomePage(), // Main home page after login
        '/nature': (context) => NatureDevelopmentPage(),
        '/learning': (context) => LearningPage(),
        '/games': (context) => LevelSelectionPage(),
        '/community': (context) => CommunityPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
      },
    );
  }
}

class BackgroundMusic {
  static final AudioPlayer player = AudioPlayer();

  static Future<void> play() async {
    await player.setSource(AssetSource('lib/assets/relaxing-piano-music-248868.mp3'));
    player.setVolume(0.5); // Adjust volume as needed
    await player.resume(); // Start playing
  }

  static void stop() async {
    await player.stop(); // Stop playing
  }

  static void loop() async {
    await player.setSource(AssetSource('lib/assets/relaxing-piano-music-248868.mp3'));
    player.setVolume(0.5); // Adjust volume as needed
    await player.resume(); // Start playing
    player.onPlayerComplete.listen((event) {
      loop(); // Loop the audio
    });
  }
}
