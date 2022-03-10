import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../databases/database.dart';
import '../../models/exercise.dart';
import '../global/list_tile/custom_list_tile.dart';

class ExerciseList extends StatelessWidget {
  const ExerciseList({
    Key? key,
    required this.planId,
    this.shrinkWrap = false,
  }) : super(key: key);

  final String planId;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    final exercises = Provider.of<List<Exercise>>(context);
    final user = Provider.of<User?>(context, listen: false);

    return exercises.isEmpty
        ? const Text('No exercises.')
        : ListView(
            shrinkWrap: shrinkWrap,
            physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
            children: exercises.map((exercise) {
              return CustomListTile(
                key: ValueKey('exercise ${exercise.id}'),
                title: exercise.name,
                subtitle:
                    '${exercise.repetitions} reps,  ${exercise.sets} sets.',
                leading: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      alignment: Alignment.center,
                      width: 46,
                      height: 46,
                      child: Text(
                        exercise.name.substring(0, 1),
                        style: const TextStyle(color: CupertinoColors.white),
                      ),
                      color: CupertinoColors.systemOrange,
                    ),
                  ),
                ),
                onLongPress: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => CupertinoActionSheet(
                      title: const Text('Confirm'),
                      message: Text(
                          'Are you sure to delete ${exercise.name} and exercises inside it?'),
                      actions: [
                        CupertinoActionSheetAction(
                          child: const Text('Delete'),
                          isDestructiveAction: true,
                          onPressed: () {
                            Navigator.pop(context);
                            DatabaseService()
                                .removeExercise(user!, planId, exercise.id);
                          },
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
  }
}
