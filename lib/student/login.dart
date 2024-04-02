// import 'package:ams_scheduler/service/auth_service.dart';
import 'package:ams_scheduler/student/resetPassword.dart';
import 'package:ams_scheduler/student/signup.dart';
import 'package:ams_scheduler/student/student_home.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});

  // final auth = AuthService();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController(); 
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Container(
          padding: const EdgeInsets.only(top: 200, left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: email,
                autofocus: false,
                validator: (value){
                  if(value == null || value.trim().isEmpty){
                    return 'Email id is required';
                  }
                  else{
                    return null;
                  }
                },
                decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
          
              const SizedBox(height: 20.0,),
          
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   PasswordField(
                    onChanged: (value) {
                      password = value.toString();
                    },
                   ),
                   Container(
                    width: 140,                
                    child: TextButton(
                      onPressed: () async{
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const resetPassword()));                        
                      }, 
                      child: const Text('Forgot Password?',
                        style: TextStyle(
                          color: Colors.purple
                        ),
                      )
                    ),
               ),
                 ],
               ),

               

              const SizedBox(height: 20,),

              Container(
                width: 360,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.amber)
                  ),
                  onPressed: () async{  
                    // final user = await auth.loginUserWithEmailAndPassword(email.text, password.toString());                  
                    // if(user!=null){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentHomePage()));
                    // }
                  }, 
                  child: const Text('Sign In',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black
                    ),
                  )
                ),                
              ),              

              const SizedBox(height: 10.0,),

              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()));
                }, 
                child: const Text("Don't have an account yet? Sign up",
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 15
                  ),
                )
              )
            ],
          ),
        )
      )
    );
  }
}

class PasswordField extends StatefulWidget {
  final ValueChanged<String>? onChanged;

   const PasswordField({super.key, this.onChanged});

  

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  late TextEditingController password;
  bool isObscuretext = true;   

    void initState(){
      super.initState();
      password = TextEditingController();
      password.addListener(() {
        widget.onChanged?.call(password.text);
      });
    }

  @override
  Widget build(BuildContext context) {

  
    
    return TextFormField(
                controller: password,                
                autofocus: false,
                validator: (value) {
                  if(value == null || value.trim().isEmpty){
                    return 'Password is required';
                  }
                  else{
                    return null;
                  }
                },
                obscureText: isObscuretext,                
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscuretext = !isObscuretext;
                      });
                    }, 
                    icon: isObscuretext? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                  ),
                      contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      labelText: 'Password',        
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
              );              
  }  
}

