import 'package:ams_scheduler/service/firebase.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MarkLeavePage extends StatelessWidget {
  String adminId;
  MarkLeavePage({super.key, required this.adminId});

  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final GlobalKey<FormState> formkey  = GlobalKey<FormState>();
  DateTime pickedDate = DateTime(DateTime.january);

  Future<void> selectDate(BuildContext context) async {
    // Function to select date
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != DateTime.now()) {
      String formattedDate = "${picked.day}/${picked.month}/${picked.year}";
      dateController.text = formattedDate;
      pickedDate = DateTime(picked.year, picked.month, picked.day);
    }
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 400,
            height: 200,
            decoration:const BoxDecoration(
              color: Colors.white
            ),
            child: Column(              
              children: [

               const Padding(
                 padding: EdgeInsets.all(8.0),
                 child: Row(                
                    children: [
                      Text('Enter date to Mark Leave',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
               ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: dateController,
                          autofocus: false,
                          validator: (value) {
                            if(value == null || value.trim().isEmpty){
                              return 'Please mark the date';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                        hintText: 'DD/MM/YYYY',            
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
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            selectDate(context);
                                          }, 
                                          icon: const Icon(Icons.calendar_month_sharp)
                                        )
                                      ),                    
                        ),
                        
                        const SizedBox(height: 20,),
                    
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                               style:  ButtonStyle(
                                  backgroundColor: const MaterialStatePropertyAll(Colors.red),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0), // Adjust the border radius as needed
                                    ),
                                  ),
                                ),
                              onPressed: () {}, 
                              child: const Text('Cancel',
                                style: TextStyle(
                                  color: Colors.white,                            
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ),
                    
                            const SizedBox(width: 20,),
                    
                    
                            ElevatedButton(
                               style:  ButtonStyle(
                                  backgroundColor: const MaterialStatePropertyAll(Colors.blue),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0), // Adjust the border radius as needed
                                    ),
                                  ),
                                ),
                              onPressed: () async{
                                if(formkey.currentState!.validate()){
                                  print(pickedDate);
                                  var response = await FirebaseCrud.markLeave(
                                    date: pickedDate, 
                                    adminId: adminId
                                  );
                                  if(response.code ==  200){
                                    Fluttertoast.showToast(
                                      msg: 'Absence marked',
                                      textColor: Colors.white,
                                      backgroundColor: Colors.green,
                                    );
                                  }
                                  else{
                                    Fluttertoast.showToast(
                                      msg: 'Absence marking failed',
                                      textColor: Colors.white,
                                      backgroundColor: Colors.red,
                                    );
                                  }
                                }
                              }, 
                              child: const Text('Mark Leave',
                                style: TextStyle(
                                  color: Colors.white,                            
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ),
                          ],
                        )
                        
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}