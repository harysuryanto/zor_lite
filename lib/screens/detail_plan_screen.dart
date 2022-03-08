import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../databases/database.dart';

class DetailPlanScreen extends StatelessWidget {
  const DetailPlanScreen({
    Key? key,
    required this.planId,
  }) : super(key: key);

  final String planId;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    final db = DatabaseService();

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Exercise List'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Text('planId: $planId'),
            // LimitedBox(
            //   maxHeight: 300,
            //   child: StreamProvider<List<Exercise>>.value(
            //     value: db.streamPlans(user!),
            //     initialData: const [],
            //     child: const ExerciseList(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
