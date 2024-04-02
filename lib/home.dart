
import 'package:ams_scheduler/official/official_home.dart';
import 'package:ams_scheduler/student/student_home.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});  
   
  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        centerTitle: true,
        title: const Text('Welcome',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),),        
      ),

      body: Center(        
        child: Container(
          padding: EdgeInsets.only(top: 200.0)          ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,          
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColorDark),            
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const OfficialHomePage()));
                  }, 
                  child: const Text("Administrative official",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),)
                ),
                
                const SizedBox(height: 20,),
          
                Container(
                        width: 250,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColorDark),            
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  const StudentHomePage()));
                          }, 
                          child: const Text("Student",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),)
                        ),
                      ),
                    

                const SizedBox(height: 20,),

                Container(
                  width: 250,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColorDark),            
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentHomePage()));
                    }, 
                    child: const Text("Faculty",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),)
                  ),
                ),
                
              ],
            ),
        ),
        ),
      );  
  }
}

