//login.dart
import 'package:ams_scheduler/LoginSignup/signup.dart';
import 'package:ams_scheduler/model/response.dart';
import 'package:ams_scheduler/official/official_home.dart';
import 'package:ams_scheduler/service/auth_service.dart';
import 'package:ams_scheduler/student/student_home.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

   final auth = AuthService();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 400,
        height: 1000,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),

        child:  Scaffold(
          backgroundColor: Colors.transparent,

          body: Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Center(            
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [                    
                    const Text('AMS',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                    ),),

                    const SizedBox(height: 30,),
                
                    Form(
                      key: formkey,
                      child: Column(
                        children: [
                          TextFormField(                      
                      controller: email,
                      autofocus: false,
                      validator: (value) {
                        if(value == null || value.trim().isEmpty){
                          return 'Email id is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        labelText: 'Email',        
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold                          
                        ),                        
                        focusColor: Colors.white,
                        hintText: 'example@gmail.com',              
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:  const BorderSide(
                            color: Colors.white,                          
                            width: 3.0,
                            style: BorderStyle.solid,
                            strokeAlign: BorderSide.strokeAlignInside
                          )
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black,                          
                            width: 3.0,                      
                          )
                        ),
                      )
                    ),

                    const SizedBox(height: 30,),

                    TextFormField(                      
                      controller: password,
                      autofocus: false,
                      validator: (value) {
                        if(value == null || value.trim().isEmpty){
                          return 'Password is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        labelText: 'Password',        
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold                          
                        ),                        
                        focusColor: Colors.white,
                        hintText: '*********',              
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:  const BorderSide(
                            color: Colors.white,                          
                            width: 3.0,
                            style: BorderStyle.solid,
                            strokeAlign: BorderSide.strokeAlignInside
                          )
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black,                          
                            width: 3.0,                      
                          )
                        ),
                      )
                    ),

                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) =>   SignupPage()));
                          }, 
                          child: const Text('Forgot password?',
                          style: TextStyle(
                            color: Colors.white
                          ),)
                        ),
                      ],
                    ),

                    const SizedBox(height: 30,),

                    Container(
                      width: 350,
                      child: ElevatedButton(
                        onPressed: () async{
                          if(formkey.currentState!.validate()){
                            final user = await auth.loginUserWithEmailAndPassword(email.text, password.text);                                                    
                            if(user?.uid != null){
                              String userid = user!.uid;  
                              String userEmail = user.email!;
                              if(userEmail == 'viceprincipal@gmail.com' || userEmail == 'viceprincipal@gmail.com' || userEmail == 'principal@gmail.com'
                                 || userEmail == 'asstmanager@gmail.com'){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  OfficialHomePage()));
                              }                                                          
                              else{
                                print('User id after login = $userid');
                                Response response = await UserDetails.getUserDetails(user.uid);                                
                                if(response.code == 200){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  StudentHomePage(uid: userid,)));                                                                                                 
                                  print('User ID = $userid');
                                }
                                else{
                                  print('Unable to get the user Details');
                                }
                              }                              
                            }                                
                          }
                        }, 
                        child: const Text('Sign In',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25
                        ),)
                      ),
                    ),                    

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account yet?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>   SignupPage()));
                          }, 
                          child: const Text('Sign Up',
                          style: TextStyle(
                            color: Colors.white
                          ),)
                        )
                      ],
                    )
                        ],
                      )
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}

