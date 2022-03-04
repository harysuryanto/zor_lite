import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../databases/database.dart';
import '../../models/plan.dart';
import '../global/list_tile/custom_list_tile.dart';

class PlanList extends StatelessWidget {
  const PlanList({
    Key? key,
    this.shrinkWrap = false,
  }) : super(key: key);

  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    final plans = Provider.of<List<Plan>>(context);
    final user = Provider.of<User?>(context);

    return plans.isEmpty
        ? const Text('No plans.')
        : ListView(
            shrinkWrap: shrinkWrap,
            children: plans.map((plan) {
              return CustomListTile(
                title: plan.name,
                leading: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        plan.name.substring(0, 1),
                        style: const TextStyle(color: CupertinoColors.white),
                      ),
                      color: CupertinoColors.systemOrange,
                    ),
                  ),
                ),
                onTap: () {
                  context.push('/detail-plan?planId=${plan.id}');
                },
                onLongPress: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => CupertinoActionSheet(
                      title: const Text('Confirm'),
                      message: Text(
                          'Are you sure to delete ${plan.name} and exercises inside it?'),
                      actions: [
                        CupertinoActionSheetAction(
                          child: const Text('Delete'),
                          isDestructiveAction: true,
                          onPressed: () {
                            DatabaseService().removePlan(user!, plan.id);
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
