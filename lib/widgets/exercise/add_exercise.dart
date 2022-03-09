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
  final formKey = GlobalKey<FormState>();
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
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Name
                          const Text('Name'),
                          const SizedBox(height: 8),
                          CupertinoTextFormFieldRow(
                            placeholder: 'E.g., Push up',
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            controller: exerciseName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please fill this input.';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

                          /// Repetitions
                          const Text('Repetitions'),
                          const SizedBox(height: 8),
                          CupertinoTextFormFieldRow(
                            controller: exerciseRepetitions,
                            placeholder: 'E.g., 20',
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please fill this input.';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

                          /// Sets
                          const Text('Sets'),
                          const SizedBox(height: 8),
                          CupertinoTextFormFieldRow(
                            controller: exerciseSets,
                            placeholder: 'E.g., 4',
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please fill this input.';
                              }
                              return null;
                            },
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
                  if (formKey.currentState!.validate()) {
                    db.addExercise(
                      user!,
                      widget.planId,
                      {
                        'name': exerciseName.text.trim(),
                        'repetitions':
                            int.tryParse(exerciseRepetitions.text.trim()),
                        'sets': int.tryParse(exerciseSets.text.trim()),
                      },
                    );
                    Navigator.pop(context);
                  }
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
