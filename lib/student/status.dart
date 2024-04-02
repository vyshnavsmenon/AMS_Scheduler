import 'package:ams_scheduler/student/approveStatus.dart';
import 'package:ams_scheduler/student/rejectStatus.dart';
import 'package:flutter/material.dart';

class StatusHomePage extends StatelessWidget {
  const StatusHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),

      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blueAccent)
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ApproveStatusPage()));
              }, 
              child: const Text('Approved',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              )
            ),

            const SizedBox(height: 20.0,),

            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blueAccent)
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RejectStatusPage()));
              }, 
              child: const Text('Rejected',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}