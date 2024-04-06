import 'package:ams_scheduler/LoginSignup/login.dart';
import 'package:ams_scheduler/student/student_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UseStatePage extends StatelessWidget {
  const UseStatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (context, userSnapshots){
        if(userSnapshots.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(userSnapshots.connectionState == ConnectionState.active){
          if(userSnapshots.hasData){
            return StudentHomePage();
          }
          else{
            return LoginPage();
          }
        }
        else if(userSnapshots.hasError){
          return const Center(
            child: SnackBar(content: Text('Something went wrong'))
          );
        }
        return Container();
      }
    );
  }
}