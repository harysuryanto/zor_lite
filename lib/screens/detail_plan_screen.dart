import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../databases/database.dart';
import '../models/exercise.dart';
import '../widgets/exercise/add_exercise.dart';
import '../widgets/exercise/exercise_list.dart';
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
    final user = Provider.of<User?>(context, listen: false);

    final db = DatabaseService();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(planName),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('Add exercise'),
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return AddExercise(planId: planId);
              },
            );
          },
        ),
        previousPageTitle: 'Home',
      ),
      child: ScaffoldBodyWithSafeArea(
        children: [
          const Text(
            'Exercises',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          StreamProvider<List<Exercise>>.value(
            value: db.streamExercises(user!, planId),
            initialData: const [],
            child: ExerciseList(
              planId: planId,
              shrinkWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
