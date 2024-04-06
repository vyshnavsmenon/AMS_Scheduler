// import 'package:ams_scheduler/home.dart';
import 'dart:io';
import 'package:ams_scheduler/useState.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDmXA9mGqcYfquI3BuC79iwR-oDv0edJ04", 
      appId: "1:1030273858687:android:5b47d97ba1c9b33f64534a", 
      messagingSenderId: "1030273858687", 
      projectId: "appointmentscheduler4"
    ),
  )
  : await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UseStatePage()
    );  
  }
}

