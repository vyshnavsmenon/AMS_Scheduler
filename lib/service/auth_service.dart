//auth_service.dart
import 'package:ams_scheduler/model/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference collection = firestore.collection('Users');

class AuthService {

  final auth = FirebaseAuth.instance;

   Future<User?> createUserWithEmailAndPassword(String email, String password, String fullName) async{
    try{
      final userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      await UserDetails.addUserDetails(
                              fullName: fullName, 
                              email: email,
                              userId: userCredential.user!.uid,
                            );
      return userCredential.user;
    }
    catch(e){
      Fluttertoast.showToast(
        msg: "Something went wrong"
      );
      return null;
    }

  }

  Future<User?> loginUserWithEmailAndPassword(String email, String password) async{
    try{
      final userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }
    catch(e){
      Fluttertoast.showToast(
        msg: "Invalid user credentials"
      );
      return null;
    }
  }

  Future<void> signOut() async{
    try{
      await auth.signOut();
    }
    catch(e) {
      Fluttertoast.showToast(
        msg: "Something went wrong"
      );
    }
  }

  Future<void> resetPassword(String email) async{
    try{
      await auth.sendPasswordResetEmail(email: email);
    }
    catch(e){
      Fluttertoast.showToast(
        msg: "Something went wrong $e"
      );
    }
  }
}

class UserDetails{

  static Future<Response> addUserDetails({
    required String userId,
    required String fullName,
    required String email,    
  }) async{
    Response response = Response();
    DocumentReference documentReferencer = collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "fullName" : fullName,
      "Email id" : email,
      "userId" : userId
    };

    await documentReferencer.set(data).whenComplete(() {
      response.code = 200;      
    })

    .catchError((e){
      response.code = 500;
      response.message = "$e";
    });

    return response;
  }

  // static Future<Response> getUserDetails(String userId) async {
  //   Response response = Response();

  //   try {
  //     DocumentSnapshot documentSnapshot = await collection.doc(userId).get();

  //     if (documentSnapshot.exists) {
  //       response.code = 200;
  //       response.data = documentSnapshot.data();
  //     } else {
  //       response.code = 404;
  //       response.message = "User not found";
  //     }
  //   } catch (e) {
  //     response.code = 500;
  //     response.message = "$e";
  //   }

  //   return response;
  // }

}

