import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {

  final auth = FirebaseAuth.instance;

   Future<User?> createUserWithEmailAndPassword(String email, String password) async{
    try{
      final userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
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
      final UserCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      return UserCredential.user;
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