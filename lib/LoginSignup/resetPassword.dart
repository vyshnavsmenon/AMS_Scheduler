import 'package:ams_scheduler/LoginSignup/login.dart';
import 'package:ams_scheduler/service/auth_service.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: 400,
          height: 200,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Please provide your Email ID',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),

              const SizedBox(height: 10.0,),

              TextFormField(
                controller: emailController,
                autofocus: false,
                validator: (value) {
                  if(value == null || value.trim().isEmpty){
                    return 'This field is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      labelText: 'Email',        
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold
                      ),              
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:  BorderSide(
                          color: Colors.blue.shade600,                          
                          width: 3.0,
                          style: BorderStyle.solid,
                          strokeAlign: BorderSide.strokeAlignInside
                        )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.red,                          
                          width: 3.0,                      
                        )
                      ),
                    )
              ),

              const SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [ElevatedButton(
                    style:  ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0), // Adjust the border radius as needed
                        ),
                      ),
                    ),
                    onPressed: () async{
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    }, 
                    child: const Text('Cancel',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )
                  ),

                  const SizedBox(width: 10,),


                  ElevatedButton(
                    style:  ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(Colors.blueAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0), // Adjust the border radius as needed
                        ),
                      ),
                    ),
                    onPressed: () async{
                      await auth.resetPassword(emailController.text);
                    }, 
                    child: const Text('Reset Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}