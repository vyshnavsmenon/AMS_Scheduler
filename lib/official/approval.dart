import 'package:ams_scheduler/service/firebase.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ApproveOrReject extends StatelessWidget {
   ApproveOrReject({super.key});

  final Stream<QuerySnapshot> collectionReference = FirebaseCrud.read();
  final Stream<QuerySnapshot> collectionReference1 = FirebaseCrud.readApprove();
  final Stream<QuerySnapshot> collectionReference2 = FirebaseCrud.readReject();
  bool isApproved = false;  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Theme.of(context).primaryColorDark,
        title: const Text("Appointment Requests",
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),

      body: StreamBuilder(
        stream: collectionReference, 
        builder: (context, snapshots){
          if(snapshots.hasData){
            List appointmentDetails = snapshots.data!.docs;

            return ListView.builder(              
              itemCount: appointmentDetails.length,
              itemBuilder: (context ,index) {
                DocumentSnapshot document = appointmentDetails[index];
                String docId = document.id;
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                String name = data['name'] ?? '';
                String date = data['date'] ?? '';
                String time = data['time'] ?? '';

                return ListTile(
                  title: Text(name),
                  subtitle: Text("$date  $time"),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async{
                          isApproved = true;
                          var response = await FirebaseCrud.approveReject(
                            docId: docId, 
                            isApproved: isApproved, 
                            name: data['name'],
                            toName: data['toName'],
                            date: data['date'],
                            time: data['time'], 
                            studentId: data['studentId'], 
                                                       
                          );
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
                        icon: const Icon(Icons.check_circle),
                        color: Colors.green,
                      ),

                      IconButton(
                        onPressed: () async{
                          isApproved = false;
                          var response = await FirebaseCrud.approveReject(
                            docId: docId, 
                            isApproved: isApproved,
                            name: data['name'],
                            toName: data['toName'],
                            date: data['date'],
                            time: data['time'],  
                            studentId: data['studentId']
                          );
                          if(response.code == 200){
                            if(isApproved){
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
                          }
                          else{
                            Fluttertoast.showToast(
                              msg: response.message.toString(),
                              textColor: Colors.white,
                              backgroundColor: Colors.red,
                            );
                          }
                        }, 
                        icon: const Icon(Icons.cancel),
                        color: Colors.red,
                      )
                    ],
                  ),
                );
              }              
            );
          }
          else{
            return Container();
          }
        }
      ),
    );
  }
}