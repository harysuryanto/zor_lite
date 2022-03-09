import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../databases/database.dart';
import '../widgets/global/ScaffoldBodyWithSafeArea/scaffold_body_with_safe_area.dart';

class AddPlanScreen extends StatefulWidget {
  const AddPlanScreen({Key? key}) : super(key: key);

  @override
  State<AddPlanScreen> createState() => _AddPlanScreenState();
}

class _AddPlanScreenState extends State<AddPlanScreen> {
  final formKey = GlobalKey<FormState>();
  final planName = TextEditingController();

  List schedules = [];

  bool isScheduledSunday = false;
  bool isScheduledMonday = false;
  bool isScheduledTuesday = false;
  bool isScheduledWednesday = false;
  bool isScheduledThursday = false;
  bool isScheduledFriday = false;
  bool isScheduledSaturday = false;

  void updateSchedules() {
    isScheduledSunday
        ? !schedules.contains('sunday')
            ? schedules.add('sunday')
            : null
        : schedules.remove('sunday');
    isScheduledMonday
        ? !schedules.contains('monday')
            ? schedules.add('monday')
            : null
        : schedules.remove('monday');
    isScheduledTuesday
        ? !schedules.contains('tuesday')
            ? schedules.add('tuesday')
            : null
        : schedules.remove('tuesday');
    isScheduledWednesday
        ? !schedules.contains('wednesday')
            ? schedules.add('wednesday')
            : null
        : schedules.remove('wednesday');
    isScheduledThursday
        ? !schedules.contains('thursday')
            ? schedules.add('thursday')
            : null
        : schedules.remove('thursday');
    isScheduledFriday
        ? !schedules.contains('friday')
            ? schedules.add('friday')
            : null
        : schedules.remove('friday');
    isScheduledSaturday
        ? !schedules.contains('saturday')
            ? schedules.add('saturday')
            : null
        : schedules.remove('saturday');
  }

  @override
  void dispose() {
    planName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final db = DatabaseService();
    final user = Provider.of<User?>(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Add New Plan'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('Save'),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              updateSchedules();

              db.addPlan(
                user!,
                {
                  'name': planName.text.trim(),
                  'schedules': schedules,
                },
              );
              context.pop();
            }
          },
        ),
        previousPageTitle: 'Home',
      ),
      child: ScaffoldBodyWithSafeArea(
        children: [
          /// Plan name
          const Text('Name'),

          const SizedBox(height: 8),

          Form(
            key: formKey,
            child: CupertinoTextFormFieldRow(
              controller: planName,
              keyboardType: TextInputType.name,
              placeholder: 'E.g., Upper body workout',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill this input.';
                }
                return null;
              },
            ),
          ),

          const SizedBox(height: 24),

          /// Schedule
          const Text('Schedules'),

          const SizedBox(height: 8),

          Row(
            children: [
              Material(
                child: Checkbox(
                  value: isScheduledSunday,
                  onChanged: (value) {
                    setState(() => isScheduledSunday = value!);
                    updateSchedules();
                  },
                ),
              ),
              const Text('Sunday'),
            ],
          ),
          Row(
            children: [
              Material(
                child: Checkbox(
                  value: isScheduledMonday,
                  onChanged: (value) {
                    setState(() => isScheduledMonday = value!);
                    updateSchedules();
                  },
                ),
              ),
              const Text('Monday'),
            ],
          ),

          Row(
            children: [
              Material(
                child: Checkbox(
                  value: isScheduledTuesday,
                  onChanged: (value) {
                    setState(() => isScheduledTuesday = value!);
                    updateSchedules();
                  },
                ),
              ),
              const Text('Tuesday'),
            ],
          ),

          Row(
            children: [
              Material(
                child: Checkbox(
                  value: isScheduledWednesday,
                  onChanged: (value) {
                    setState(() => isScheduledWednesday = value!);
                    updateSchedules();
                  },
                ),
              ),
              const Text('Wednesday'),
            ],
          ),

          Row(
            children: [
              Material(
                child: Checkbox(
                  value: isScheduledThursday,
                  onChanged: (value) {
                    setState(() => isScheduledThursday = value!);
                    updateSchedules();
                  },
                ),
              ),
              const Text('Thursday'),
            ],
          ),

          Row(
            children: [
              Material(
                child: Checkbox(
                  value: isScheduledFriday,
                  onChanged: (value) {
                    setState(() => isScheduledFriday = value!);
                    updateSchedules();
                  },
                ),
              ),
              const Text('Friday'),
            ],
          ),

          Row(
            children: [
              Material(
                child: Checkbox(
                  value: isScheduledSaturday,
                  onChanged: (value) {
                    setState(() => isScheduledSaturday = value!);
                    updateSchedules();
                  },
                ),
              ),
              const Text('Saturday'),
            ],
          ),
        ],
      ),
    );
  }
}
