import 'package:ams_scheduler/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final auth = AuthService();

  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,

        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Padding(
                  padding:  EdgeInsets.only(top: 100.0),
                  child:  Text('AMS',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                      ),),                      
                ),

                const SizedBox(height: 30,),

                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(                      
                      controller: fullName,
                      autofocus: false,
                      validator: (value) {
                        if(value == null || value.trim().isEmpty){
                          return 'Password is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        labelText: 'Full Name',        
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold                          
                        ),                        
                        focusColor: Colors.white,
                        // hintText: '*******',              
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

                    const SizedBox(height: 20,),

                    TextFormField(                      
                      controller: email,
                      autofocus: false,
                      validator: (value) {
                        if(value == null || value.trim().isEmpty){
                          return 'Password is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        labelText: 'Email id',        
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

                    const SizedBox(height: 20,),

                    TextFormField(                      
                      controller: password,
                      autofocus: false,
                      obscureText: true,
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
                        hintText: '********',              
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

                    const SizedBox(height: 20,),

                    TextFormField(                      
                      controller: confirmPassword,
                      autofocus: false,
                      obscureText: true,
                      validator: (value) {
                        if(value == null || value.trim().isEmpty){
                          return 'Password is required';
                        }
                        else if(password.text != confirmPassword.text){
                          return "Password didn't match";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        labelText: 'Confirm Password',        
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold                          
                        ),                        
                        focusColor: Colors.white,
                        hintText: '********',              
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

                    Container(
                      width: 400,
                      child: ElevatedButton(
                        onPressed: () async{
                          if(formkey.currentState!.validate()){
                            var user = await auth.createUserWithEmailAndPassword(email.text, password.text, fullName.text);                                                        
                            if(user!=null){
                              Fluttertoast.showToast(
                                msg: 'Account Created Successfully',
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                              );
                            }
                          }
                        }, 
                        child: const Text('Create Account',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold                            
                          ),
                        )
                      ),
                    )
                    ],
                  )
                )
              ],
            ),
          ),
        ),
    );
  }
}