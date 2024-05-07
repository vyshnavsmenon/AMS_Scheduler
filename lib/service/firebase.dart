
import 'package:ams_scheduler/model/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference collection = firestore.collection('Schedule-Details');

final FirebaseFirestore firestore1 = FirebaseFirestore.instance;
final CollectionReference collection1 = firestore1.collection('Approval');

final FirebaseFirestore firestore2 = FirebaseFirestore.instance;
final CollectionReference collection2 = firestore2.collection('Reject');

final FirebaseFirestore firestore3 = FirebaseFirestore.instance;
final CollectionReference collection3 = firestore3.collection('LeaveDate');

class FirebaseCrud{

  static Future<Response> addScheduleDetails({
    required String name,
    required String toName,
    required String date,
    required String time,
    required String studentId,
    required String adminId,
  })async{

    Response response = Response();
    DocumentReference documentReferencer = collection.doc();
    // DocumentReference documentReferencer1 = collection3.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "name" : name,
      "toName" : toName,
      "date" : date,
      "time" : time,
      "isApproved" : "",
      "studentId" : studentId,
      "adminId" : adminId
    };

    await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Appointment Scheduled for $date at $time";
    })

    .catchError((e){
      response.code = 500;
      response.message = "Appointment scheduling failed due to $e";
    });    

    return response;
  }

  static Stream<QuerySnapshot> read({
    required String uid
  }) {
  return collection
      .where('isApproved', isEqualTo: "")
      .where('adminId', isEqualTo: uid)
      .snapshots();
  }
  
  static Stream<QuerySnapshot> readStudentScheduleDetails(){
    CollectionReference collectionReference = collection;
    return collectionReference.snapshots();
  }

  static Stream<QuerySnapshot> readApprove(){
    CollectionReference collectionReference = collection1;
    return collectionReference.snapshots();
  }

  static Stream<QuerySnapshot> readReject(){
    CollectionReference collectionReference = collection2;
    return collectionReference.snapshots();
  }

  static Future<Response> updateScheduleDetails({
    required String name,
    required String toName,
    required String date,
    required String time,
    required String docId,
  })async{
    Response response = Response();
    DocumentReference documentReferencer = collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "name" : name,
      "toName" : toName,
      "date" : date,
      "time" : time,     
      "isApproved" : false,
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Scheduled appointment updated";
    })

    .catchError((e) {
      response.code = 500;
      response.message = "Appointment updation failed";
    });

    return response;
  }

  static Future<Response> deleteScheduleDetails({
  required String docId}
  )async{
    Response response = Response();
    DocumentReference documentReferencer = collection.doc(docId);

    await documentReferencer.delete().whenComplete((){
      response.code = 200;
      response.message = 'Appointment cancelled';
    })

    .catchError((e) {
      response.code = 500;
      response.message = "Cancellation denied";
    });

    return response;
  }

  static Future<Response> markVisited({
  required String docId}
  )async{
    Response response = Response();
    DocumentReference documentReferencer = collection.doc(docId);

    await documentReferencer.delete().whenComplete((){
      response.code = 200;
      response.message = 'Appointment cancelled';
    })

    .catchError((e) {
      response.code = 500;
      response.message = "Cancellation denied";
    });

    return response;
  }

  static Future<Response> approveReject({
  required String docId,  
  required bool isApproved,
  required String name,
  required String toName,
  required String date,
  required String time,
  required String studentId,
  })async{
    Response response = Response();
    DocumentReference documentReferencer = collection.doc(docId);
    DocumentReference documentReferencer1 = collection1.doc();
    DocumentReference documentReferencer2 = collection2.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "isApproved" : isApproved      
    };

    await documentReferencer.update(data).whenComplete((){
      response.code == 200;
      if(isApproved){
        response.message = "Approved";
      }      
      else{
        response.message = "Rejected";
      }
    })

    .catchError((e) {
      response.code = 500;    
      response.message = "$e";
    });    

    if(isApproved){
      Map<String, dynamic> data1 = <String, dynamic>{
      "name" : name,
      "toName" : toName,
      "date" : date,
      "time" : time,
      "isApproved" : isApproved,
      "studentId" : studentId
    };

    await documentReferencer1.set(data1);
    }
    else{
      Map<String, dynamic> data2 = <String, dynamic>{
      "name" : name,
      "toName" : toName,
      "date" : date,
      "time" : time,
      "isApproved" : isApproved,
      "studentId" : studentId
    };

      await documentReferencer2.set(data2);
    }

    
    
    return response;
  }  

  static Future<Response> markLeave({
    required DateTime date,
    required String adminId
  })   async {
    
    Response response = Response();
    DocumentReference documentReferencer = collection3.doc();

    Map<String ,dynamic> data = <String,dynamic>{
      "date" : date,
      "adminId" : adminId
    };

    documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Leave marked on $date";
    })

    .catchError((e) {
      response.code = 500;
      response.message = "Leave marking failed";
    });

    return response;

  }
}


