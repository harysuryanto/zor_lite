import 'package:cloud_firestore/cloud_firestore.dart';

class Plan {
  final String id;
  final String name;
  final List<Map<String, dynamic>> exercises;

  Plan({
    required this.id,
    required this.name,
    required this.exercises,
  });

  factory Plan.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;

    return Plan(
      id: doc.id,
      name: data['name'],
      exercises: data['exercises'] ?? [],
    );
  }
}
