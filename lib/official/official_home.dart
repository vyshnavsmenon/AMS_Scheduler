import 'package:ams_scheduler/LoginSignup/login.dart';
import 'package:ams_scheduler/official/approval.dart';
import 'package:ams_scheduler/service/auth_service.dart';
import 'package:flutter/material.dart';

class OfficialHomePage extends StatelessWidget {
  final String uid; // Add this line to declare the uid variable

    // Modify the constructor to accept uid as a parameter
    OfficialHomePage({Key? key, required this.uid}) : super(key: key);

  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        iconTheme:const  IconThemeData(
          color: Colors.white,
        ),
        title: const Text('Appointments',
         style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
         ),),
         centerTitle: true,
         actions: [
          IconButton(
            onPressed: () async{
              await auth.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            }, 
            icon: const Icon(Icons.logout)
          )
         ],
      ),

      body: Center( 
          child:ElevatedButton(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.blue)          
          ),        
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ApproveOrReject(uid: uid,)));
          }, 
          child: const Text('Appointments',
            style: TextStyle(
              color: Colors.white,            
            ),
          )
        ),
      ),
    );
  }
}