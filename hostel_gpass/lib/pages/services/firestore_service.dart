import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add gate pass request
  Future<void> addGatePassRequest({
    required String userId,
    required String reason,
    required String date,
  }) async {
    await _db.collection('gate_pass_requests').add({
      'userId': userId,
      'reason': reason,
      'date': date,
      'status': 'Pending',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Approve or reject gate pass
  Future<void> updateGatePassStatus(String docId, String newStatus) async {
    await _db.collection('gate_pass_requests').doc(docId).update({
      'status': newStatus,
    });
  }

  // Get user-specific gate pass history
  Stream<QuerySnapshot> getUserRequests(String userId) {
    return _db
        .collection('gate_pass_requests')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // Get all pending requests (admin view)
  Stream<QuerySnapshot> getPendingRequests() {
    return _db
        .collection('gate_pass_requests')
        .where('status', isEqualTo: 'Pending')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
