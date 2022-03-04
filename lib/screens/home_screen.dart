import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../databases/database.dart';
import '../models/plan.dart';
import '../providers/user.dart';
import '../widgets/login/login.dart';
import '../widgets/plan/plan_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final isLoggedIn = user != null;

    final db = DatabaseService();

    if (!isLoggedIn) {
      return const CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Login'),
        ),
        child: Center(child: Login()),
      );
    }

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Zor Lite'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Welcome ${user.displayName ?? user.uid}',
                  textAlign: TextAlign.center,
                ),
                CupertinoButton(
                  child: const Text('Sign out'),
                  onPressed: () => UserAuth().logout(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              child: const Text('Add plan'),
              onPressed: () {
                context.push('/add_plan_screen');
              },
            ),
            const SizedBox(height: 20),
            StreamProvider<List<Plan>>.value(
              value: db.streamPlans(user),
              initialData: const [],
              child: const PlanList(shrinkWrap: true),
            ),
          ],
        ),
      ),
    );
  }
}
