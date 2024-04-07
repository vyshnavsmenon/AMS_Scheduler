import 'package:ams_scheduler/LoginSignup/login.dart';
import 'package:ams_scheduler/official/official_home.dart';
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
            String userid = userSnapshots.data!.uid;
            if(userid == 'yZBDp2Q525ezRQ7GulFkhOU1WkN2' || userid == '5fGUI3q38VRIyi6gKFcmR1IpRx43' || userid == '7LKsnd5f5VcE6g8uevU1V1Oacqy1' || 
            userid == 'TtPrAc2vz1Rrf4Sq2uSUl1O8Tw23' || userid == 'W9dXEJMg3Nf1lODg09nol3WSCQ03' ){
              return OfficialHomePage(uid: userid);
            }
            else{
              return StudentHomePage(uid: userid,);
            }            
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