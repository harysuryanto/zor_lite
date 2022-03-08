import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../databases/database.dart';
import '../widgets/global/ScaffoldBodyWithSafeArea/scaffold_body_with_safe_area.dart';

class AddExerciseScreen extends StatefulWidget {
  const AddExerciseScreen({
    Key? key,
    required this.planId,
    required this.planName,
  }) : super(key: key);

  final String planId;
  final String planName;

  @override
  State<AddExerciseScreen> createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    final db = DatabaseService();
    final user = Provider.of<User?>(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Add New Exercise in ${widget.planName}'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('Save'),
          onPressed: () {
            // db.addPlan(
            //   user!,
            //   {
            //     'name': planName.text,
            //     'schedules': schedules,
            //   },
            // );
            // context.pop();
          },
        ),
        previousPageTitle: 'Home',
      ),
      child: const ScaffoldBodyWithSafeArea(
        children: [
          /// Plan name
          Text('Add Exercise Screen'),

          SizedBox(height: 8),

          SizedBox(height: 24),
        ],
      ),
    );
  }
}
