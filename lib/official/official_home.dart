import 'package:ams_scheduler/official/approval.dart';
import 'package:flutter/material.dart';

class OfficialHomePage extends StatelessWidget {
  const OfficialHomePage({super.key});

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
      ),

      body: Center( 
          child:ElevatedButton(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.blue)          
          ),        
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ApproveOrReject()));
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