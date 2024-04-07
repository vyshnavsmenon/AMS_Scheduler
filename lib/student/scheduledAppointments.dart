import 'package:ams_scheduler/student/editScheduler.dart';
import 'package:ams_scheduler/service/firebase.dart';
import 'package:ams_scheduler/student/schedule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScheduledAppointment extends StatelessWidget {
    final String uid; // Add this line to declare the uid variable

    // Modify the constructor to accept uid as a parameter
    ScheduledAppointment({Key? key, required this.uid}) : super(key: key);

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
                String userId = data['studentId'];

                print('User id in sceduled appointment = $userId');

                if(toName == "1"){
                  toName = "Vice Principal - Academics";
                }
                else if(toName == "2"){
                  toName = "Vice Principal - Administer";
                }
                else if(toName == "3"){
                  toName = "Principal";
                }
                else if(toName == "4"){
                  toName = "Asst. Manager";
                }
                else if(toName == "5"){
                  toName = "Manager";
                }

                if(userId == uid){
                  return ListTile(                  
                    title: Text('To Meet: $toName'),                                            
                    subtitle: Text('Date: $date \nTime: $time'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditScheduleDetails(docId: docId, uid: uid,)));
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
              }              
            );
          }
          else{
                  return Container(
                    padding: const EdgeInsets.only(top: 200),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         const Text('You don\'t have any appointments yet.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),
                        ),

                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ScheduleAppointment(uid: uid)));
                          }, 
                          child: const Text('Take Appointment',
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        )
                      ],
                    ),
                  );
                }          
        }
      ),
    );
  }
}


