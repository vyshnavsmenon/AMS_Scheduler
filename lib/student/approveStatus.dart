import 'package:ams_scheduler/service/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ApproveStatusPage extends StatelessWidget {  
   final String uid; // Add this line to declare the uid variable

    // Modify the constructor to accept uid as a parameter
    ApproveStatusPage({Key? key, required this.uid}) : super(key: key);

  final Stream<QuerySnapshot> collectionReference = FirebaseCrud.readApprove();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Theme.of(context).primaryColorDark,
        title: const Text('Status',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
          .collection('Approval')
          .where('studentId', isEqualTo: uid)
          .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          final approvedList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: approvedList.length,
            itemBuilder: (context, index) {
              final document = approvedList[index];
              final data = document.data() as Map<String, dynamic>;
              final toName = data['toName'] ?? '';
              final date = data['date'] ?? '';
              final time = data['time'] ?? '';
              final isApproved = data['isApproved'] ?? false;                           

              String approvedToName = '';
              switch (toName) {
                case '1':
                  approvedToName = 'Vice Principal - Academics';
                  break;
                case '2':
                  approvedToName = 'Vice Principal - Administration';
                  break;
                case '3':
                  approvedToName = 'Principal';
                  break;
                case '4':
                  approvedToName = 'Asst. Manager';
                  break;
                case '5':
                  approvedToName = 'Manager';
                  break;
              }
              

              if (isApproved) {                
                  return ListTile(
                    title: Text(approvedToName),
                    subtitle: Text('$date $time'),                    
                  );
              }

              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
