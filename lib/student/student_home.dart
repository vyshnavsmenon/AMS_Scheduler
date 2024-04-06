import 'package:ams_scheduler/service/auth_service.dart';
import 'package:ams_scheduler/student/schedule.dart';
import 'package:ams_scheduler/student/scheduled.dart';
import 'package:ams_scheduler/student/status.dart';
import 'package:flutter/material.dart';

class StudentHomePage extends StatelessWidget {    
    StudentHomePage({super.key});

   final auth = AuthService();

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(        
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Theme.of(context).primaryColorDark,
        centerTitle: true,
        title: const Text('Welcome',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),),        
        actions:[IconButton(
          onPressed: () async{
            await auth.signOut();
          }, 
            icon: const Icon(Icons.logout)
          ),
        ] 
      ),

      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top:200.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 300,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColorDark),            
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  ScheduleAppointment()));
                  }, 
                  child: const Text("Schedule Appointment",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),)
                ),
              ),

              const SizedBox(height: 20,),
        
              Container(
                width: 300,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColorDark),            
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>   ScheduledAppointment()));
                  }, 
                  child: const Text("Scheduled Appointment",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),)
                ),
              ),

              const SizedBox(height: 20,),
        
              Container(
                width: 300,
                child: ElevatedButton(              
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColorDark),            
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>   StatusHomePage()));
                  }, 
                  child: const Text("Status",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),)
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}