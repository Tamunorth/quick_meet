import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_meet/services/auth_service.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final AuthService _authService = AuthService();

  Stream<QuerySnapshot<Map<String, dynamic>>> get meetingsHistory => _firestore
      .collection('users')
      .doc(_authService.user.uid)
      .collection('meetings')
      .snapshots();

  addToMeetingHistory(String meetingName) async {
    try {
      await _firestore
          .collection('users')
          .doc(_authService.user.uid)
          .collection('meetings')
          .add({
        'meetingName': meetingName,
        'createdAt': DateTime.now(),
      });
    } on FirebaseException catch (e) {
      rethrow;
    }
  }
}
