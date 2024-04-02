import 'package:ams_scheduler/student/editScheduler.dart';
import 'package:ams_scheduler/service/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScheduledAppointment extends StatelessWidget {
   ScheduledAppointment({super.key});

  final Stream<QuerySnapshot> collectionReference = FirebaseCrud.readStudentScheduleDetails();  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColorDark,
        title: const Text('Appointments',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
      ),

      body: StreamBuilder(
        stream: collectionReference, 
        builder: (context, snapshot) {
          if(snapshot.hasData){
            List appointmentDetails = snapshot.data!.docs;

            return ListView.builder(
              itemCount: appointmentDetails.length,
              itemBuilder: (context, index){
                DocumentSnapshot document = appointmentDetails[index];
                String docId = document.id;
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;                
                String toName = data['toName'] ?? '';
                String date = data['date'] ?? '';
                String time = data['time'] ?? '';

                if(toName == "1"){
                  toName = "Vice Principal";
                }
                else if(toName == "2"){
                  toName = "Principal";
                }
                else if(toName == "3"){
                  toName = "Asst. Manager";
                }
                else if(toName == "4"){
                  toName = "Manager";
                }

                return ListTile(                  
                  title: Text('To Meet: $toName'),                                            
                  subtitle: Text('Date: $date \nTime: $time'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditScheduleDetails(docId: docId,)));
                        }, 
                        icon: Icon(Icons.edit)
                      ),
                      IconButton(
                        onPressed: () async {
                          var response = await FirebaseCrud.deleteScheduleDetails(docId: docId);
                          if(response.code == 200){
                            Fluttertoast.showToast(
                              msg: response.message.toString(),
                              textColor: Colors.white,
                              backgroundColor: Colors.green,                              
                            );
                          }
                          else{
                            Fluttertoast.showToast(
                              msg: response.message.toString(),
                              textColor: Colors.white,
                              backgroundColor: Colors.red,                              
                            );
                          }
                        }, 
                        icon: const Icon(Icons.delete)
                      ),                      
                       IconButton(
                        onPressed: () async{                         
                          var response = await FirebaseCrud.markVisited(docId: docId);
                          if(response.code == 200){
                            Fluttertoast.showToast(
                              msg: 'Mark visited',
                              textColor: Colors.white,
                              backgroundColor: Colors.green,
                            );
                          }
                        }, 
                        icon: const Icon(Icons.check_box),
                        color: Colors.red
                      )
                    ],
                  ),                                                      
                );
              }
            );
          }
          return Container();
        }
      ),
    );
  }
}


