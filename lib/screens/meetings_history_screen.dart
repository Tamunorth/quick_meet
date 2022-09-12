import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quick_meet/services/firestore_service.dart';

class MeetingsHistoryScreen extends StatelessWidget {
  const MeetingsHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirestoreService().meetingsHistory,
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
              itemCount: (snapshots.data! as dynamic).docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      'Room Name: ${(snapshots.data! as dynamic).docs[index]['meetingName']}'),
                  subtitle: Text('Joined on: ${DateFormat.yMMMd().format(
                    (snapshots.data! as dynamic)
                        .docs[index]['createdAt']
                        .toDate(),
                  )}'),
                );
              });
        });
  }
}
