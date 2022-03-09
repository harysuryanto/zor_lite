import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../databases/database.dart';

class AddExercise extends StatefulWidget {
  const AddExercise({
    Key? key,
    required this.planId,
  }) : super(key: key);

  final String planId;

  @override
  State<AddExercise> createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  final exerciseName = TextEditingController();
  final exerciseRepetitions = TextEditingController();
  final exerciseSets = TextEditingController();

  @override
  void dispose() {
    exerciseName.dispose();
    exerciseRepetitions.dispose();
    exerciseSets.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final db = DatabaseService();
    final user = Provider.of<User?>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _customContainer(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Add exercise',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Name
                          const Text('Name'),
                          const SizedBox(height: 8),
                          CupertinoTextField(
                            controller: exerciseName,
                            placeholder: 'E.g., Push up',
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                          ),

                          const SizedBox(height: 16),

                          /// Repetitions
                          const Text('Repetitions'),
                          const SizedBox(height: 8),
                          CupertinoTextField(
                            controller: exerciseRepetitions,
                            placeholder: 'E.g., 20',
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                          ),

                          const SizedBox(height: 16),

                          /// Sets
                          const Text('Sets'),
                          const SizedBox(height: 8),
                          CupertinoTextField(
                            controller: exerciseSets,
                            placeholder: 'E.g., 4',
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            _customContainer(
              child: CupertinoButton(
                child: const Text('Save'),
                onPressed: () {
                  db.addExercise(
                    user!,
                    widget.planId,
                    {
                      'name': exerciseName.text,
                      'repetitions': int.tryParse(exerciseRepetitions.text),
                      'sets': int.tryParse(exerciseSets.text),
                    },
                  );
                  Navigator.pop(context);
                },
              ),
            ),

            /// Padding bottom to prevent content blocked by keyboard
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }

  Container _customContainer({required Widget child}) {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: child,
    );
  }
}
