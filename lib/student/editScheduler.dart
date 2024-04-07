// import 'package:flutter/foundation.dart';
import 'package:ams_scheduler/service/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditScheduleDetails extends StatefulWidget {
  final String uid;
  final String docId;
  EditScheduleDetails({Key? key, required this.uid, required this.docId}) : super(key: key);

  @override
  State<EditScheduleDetails> createState() => _EditScheduleDetailsState();
}

class _EditScheduleDetailsState extends State<EditScheduleDetails> {
  final TextEditingController name = TextEditingController();
  final TextEditingController toNameontroller = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String username = "";
  String toName = "";
  String date = "";
  String time = "";

  final Stream<QuerySnapshot> collectionReference = FirebaseCrud.read();
  // var data;
  List<Map<String, dynamic>> documentData = [];  

  String? docId;
  int currentvalue = 1;


  Future<void> selectDate(BuildContext context) async{
    final DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), 
      lastDate: DateTime(2100),
    );
    if(picked != null){
      String formattedDate = '${picked.day}/${picked.month}/${picked.year}';
      dateController.text = formattedDate;
    }
  }

  Future<void> selectTime(BuildContext context) async{
    final TimeOfDay? picked = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now()
    );
    if(picked!=null){
      timeController.text = picked.format(context);
    }
  }

  void initState() {  
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async{
    try{
      DocumentSnapshot snapshot = (await FirebaseFirestore.instance
            .collection('Schedule-Details')
            .doc(widget.docId)          
            .get());

      if(snapshot.exists){        
        username = snapshot['name'];
        name.text = username;
        toName = snapshot['toName'];
        toNameontroller.text = toName;
        date = snapshot['date'];
        dateController.text = date;
        time = snapshot['time'];
        timeController.text = time;
      }else{
        print('Username doesnot exist');
      }
    }
    catch(e){
      print('Unable to fetch user name due to $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    docId = widget.docId;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),

      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formkey,
          child: Column(
          children: [            
                  TextFormField(              
                    controller: name,
                    autofocus: false,
                    validator: (value) {
                      if(value==null || value.trim().isEmpty){
                        return 'This field is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      labelText: 'Name',        
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

                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      width: 360,
                      decoration: BoxDecoration(                        
                          border: Border.all(color: Colors.red, width: 3.0),                          
                          borderRadius: BorderRadius.circular(10.0)),                                                                           
                      child:  DropdownButton(   
                        underline: Container(),                        
                        items: const [
                          DropdownMenuItem(value: 1, child: Text('Vice principal')),
                          DropdownMenuItem(value: 2, child: Text('Principal')),
                          DropdownMenuItem(value: 3, child: Text('Asst. Manager')),
                          DropdownMenuItem(value: 4, child: Text('Manager')),
                        ],
                        value: currentvalue,
                        onChanged: (value) {
                          setState(() {
                            currentvalue = value!;
                          });
                        },
                      ),),

                      const SizedBox(height: 20,),

                      TextFormField(              
                    controller: dateController,
                    autofocus: false,
                    validator: (value) {
                      if(value==null || value.trim().isEmpty){
                        return 'This field is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      suffixIcon: IconButton(
                        onPressed: () {
                          selectDate(context);
                        }, 
                        icon: const Icon(Icons.calendar_month_rounded)
                      ),                    
                      labelText: 'Choose date',  
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

                    TextFormField(              
                    controller: timeController,
                    autofocus: false,
                    validator: (value) {
                      if(value==null || value.trim().isEmpty){
                        return 'This field is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      suffixIcon: IconButton(
                        onPressed: () {
                          selectTime(context);
                        }, 
                        icon: const Icon(Icons.access_time)
                      ),                    
                      labelText: 'Choose time',  
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

                    StreamBuilder(
                      stream: collectionReference, 
                      builder: (context, snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return CircularProgressIndicator();
                        }
                        if(snapshot.hasError){
                          Fluttertoast.showToast(
                            msg: 'Snapshot Error!!!',
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        }
                        final documents = snapshot.data!.docs;
                        documentData.clear(); // Clear the list before adding new data

                        for (var doc in documents) {
                          documentData.add(doc.data() as Map<String, dynamic>);
                        }
                        return Container();                        
                      }                      
                    ),

                    const SizedBox(height: 20,),
                                       
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.blue.shade600),
                      ),
                      onPressed: () async{
                        bool slotAvailable = true;
                        if (formkey.currentState?.validate() ?? false) {                          
                          for(var doc in documentData){
                            if(doc['toName'] == currentvalue.toString() && doc['date'] == dateController.text 
                              && doc['time'] == timeController.text){
                                slotAvailable = false;
                                Fluttertoast.showToast(
                                  msg: 'Appointment Not Available',
                                  textColor: Colors.black,
                                  backgroundColor: Colors.yellow
                                );
                                break;
                              }
                          }
                        }           

                        if(slotAvailable){
                          var response = await FirebaseCrud.updateScheduleDetails(
                            name: name.text, 
                            toName: currentvalue.toString(), 
                            date: dateController.text, 
                            time: timeController.text, 
                            docId: docId.toString());

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
                        }

                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Schedule Appointment",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                ],
              ),                       
          
        )
      )
    );  
  }
}
