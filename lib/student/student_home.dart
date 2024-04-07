// student_home.dart
import 'package:ams_scheduler/LoginSignup/login.dart';
import 'package:ams_scheduler/service/auth_service.dart';
import 'package:ams_scheduler/student/schedule.dart';
import 'package:ams_scheduler/student/scheduledAppointments.dart';
import 'package:ams_scheduler/student/status.dart';
import 'package:flutter/material.dart';

class StudentHomePage extends StatelessWidget {            
    final String uid; // Add this line to declare the uid variable

    // Modify the constructor to accept uid as a parameter
    StudentHomePage({Key? key, required this.uid}) : super(key: key);


   final auth = AuthService();

  @override
  Widget build(BuildContext context) {  
    print('User id from student = $uid');
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
          }, 
            icon: const Icon(Icons.logout)
          ),
        ],
        automaticallyImplyLeading: false,
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  ScheduleAppointment(uid: uid,)));
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
                    print('uid send to scheduled appointment = $uid');
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>   ScheduledAppointment(uid: uid,)));
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>   StatusHomePage(uid: uid,)));
                    // StatusHomePage studentId = StatusHomePage();
                    // studentId.uid = uid;
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