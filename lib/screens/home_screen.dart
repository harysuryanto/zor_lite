import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../databases/database.dart';
import '../models/plan.dart';
import '../providers/user.dart';
import '../widgets/global/ScaffoldBodyWithSafeArea/scaffold_body_with_safe_area.dart';
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
        key: ValueKey('home screen before login'),
        navigationBar: CupertinoNavigationBar(
          middle: Text('Login'),
        ),
        child: Center(child: Login()),
      );
    }

    return CupertinoPageScaffold(
      key: const ValueKey('home screen after login'),
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('Sign out'),
          onPressed: () => UserAuth().logout(),
        ),
        middle: const Text('Zor Lite'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('Add plan'),
          onPressed: () {
            context.push('/add-plan');
          },
        ),
      ),
      child: ScaffoldBodyWithSafeArea(
        children: [
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(text: 'Hi, '),
                TextSpan(
                  text: user.displayName ?? user.uid,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: ' 👋'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Plans',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          StreamProvider<List<Plan>>.value(
            value: db.streamPlans(user),
            initialData: const [],
            child: const PlanList(shrinkWrap: true),
          ),
        ],
      ),
    );
  }
}
