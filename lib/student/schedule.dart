import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ams_scheduler/service/firebase.dart';

class ScheduleAppointment extends StatefulWidget {
  final String uid; // Add this line to declare the uid variable

    // Modify the constructor to accept uid as a parameter
    ScheduleAppointment({Key? key, required this.uid}) : super(key: key);

  @override
  State<ScheduleAppointment> createState() => _ScheduleAppointmentState();
}

class _ScheduleAppointmentState extends State<ScheduleAppointment> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();  
  

  final Stream<QuerySnapshot> collectionReference = FirebaseCrud.read();
  List<Map<String, dynamic>> documentData = [];  

  bool isLoading = false; // Variable to control the loader
  bool isButtonDisabled = false; // Variable to control button state
  int currentvalue = 1;

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
    }
  }

  Future<void> selectTime(BuildContext context) async {
    // Function to select time
    final TimeOfDay? timepicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (timepicked != null && timepicked != TimeOfDay.now()) {
      timeController.text = timepicked.format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    String uid = widget.uid;
    print('USer ID from schedule page = $uid');
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColorDark,
        centerTitle: true,
        title: const Text(
          'Schedule Appointment',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameController,
                autofocus: false,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
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
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.only(left: 20),
                width: 360,
                decoration: BoxDecoration(                        
                          border: Border.all(color: Colors.red, width: 3.0),                          
                          borderRadius: BorderRadius.circular(10.0)), 
                child: DropdownButton(
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
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: dateController,
                autofocus: false,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  } else {
                    return null;
                  }
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
              const SizedBox(height: 20.0),
              TextFormField(
                controller: timeController,
                autofocus: false,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
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
              const SizedBox(height: 20.0),
              
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


              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.blue.shade600)),
                  onPressed:() async {
                    bool slotAvailable = true;
                    if(formkey.currentState?.validate() ?? false){                      
                        for(var doc in documentData){
                          if(doc['toName'] == currentvalue.toString() && doc['date'] == dateController.text && doc['time'] == timeController.text){
                            slotAvailable = false;
                            Fluttertoast.showToast(
                              msg: 'Appointment not available',
                              textColor: Colors.white,
                              backgroundColor: Colors.yellow
                            );
                            break;
                          }
                        }
                      }

                      if(slotAvailable){
                        var response = await FirebaseCrud.addScheduleDetails(
                          name: nameController.text,
                          toName: currentvalue.toString(),
                          date: dateController.text,
                          time: timeController.text,
                          studentId: uid
                        );
                        if(response.code == 200){
                          Fluttertoast.showToast(
                            msg: response.message.toString(),
                            textColor: Colors.white,
                            backgroundColor: Colors.green
                          );
                        }
                        else{
                          Fluttertoast.showToast(
                            msg: response.message.toString(),
                            textColor: Colors.white,
                            backgroundColor: Colors.red
                          );
                        }
                        Navigator.pop(context);
                      }                    
                  },
                  child: const Text(
                    "Schedule Appointment",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                )

            ],
          ),
        ),
      ),
    );
  }
}
