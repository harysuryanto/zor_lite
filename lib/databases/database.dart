import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/my_profile.dart';
import '../models/plan.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Unused method
  Future<MyProfile> getMyProfile(String id) async {
    var snap = await _db.collection('users').doc(id).get().catchError(
        (error) => print("Failed to get current profile document: $error"));

    return MyProfile.fromMap(snap.data as Map<String, dynamic>);
  }

  /// Get a stream of a single document
  Stream<MyProfile> streamMyProfile(String uid) {
    var ref = _db.collection('users').doc(uid);

    return ref.snapshots().map((snap) {
      var data = snap.data() as Map<String, dynamic>;
      return MyProfile.fromMap(data);
    });
  }

  /// Query a subcollection
  Stream<List<Plan>> streamPlans(User user) {
    var ref = _db.collection('users').doc(user.uid).collection('plans');

    return ref.snapshots().map((list) {
      return list.docs.map((doc) {
        return Plan.fromFirestore(doc);
      }).toList();
    });
  }

  Future<void> addPlan(User user, dynamic plan) {
    return _db
        .collection('users')
        .doc(user.uid)
        .collection('plans')
        .add(plan)
        .then((value) => print("Plan added"))
        .catchError((error) => print("Failed to add plan: $error"));
  }

  Future<void> removePlan(User user, String id) {
    return _db
        .collection('users')
        .doc(user.uid)
        .collection('plans')
        .doc(id)
        .delete()
        .then((value) => print("Plan deleted"))
        .catchError((error) => print("Failed to delete plan: $error"));
  }
}
