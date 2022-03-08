import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../databases/database.dart';
import '../widgets/global/ScaffoldBodyWithSafeArea/scaffold_body_with_safe_area.dart';

class DetailPlanScreen extends StatelessWidget {
  const DetailPlanScreen({
    Key? key,
    required this.planId,
    required this.planName,
  }) : super(key: key);

  final String planId;
  final String planName;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    final db = DatabaseService();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(planName),
      ),
      child: ScaffoldBodyWithSafeArea(
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
    );
  }
}
