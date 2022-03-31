import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _LoginState();
}

class _LoginState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Name
              const Text('Name'),
              const SizedBox(height: 8),
              CupertinoTextFormFieldRow(
                placeholder: 'Enter name',
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                controller: name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill this input.';
                  }
                  return null;
                },
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// Email
              const Text('Email'),
              const SizedBox(height: 8),
              CupertinoTextFormFieldRow(
                placeholder: 'Enter email',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill this input.';
                  }
                  return null;
                },
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// Password
              const Text('Password'),
              const SizedBox(height: 8),
              CupertinoTextFormFieldRow(
                controller: password,
                placeholder: 'Enter password',
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill this input.';
                  }
                  return null;
                },
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
        CupertinoButton(
          child: const Text('Register'),
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              try {
                UserCredential userCredential =
                    await auth.createUserWithEmailAndPassword(
                  email: email.text.trim(),
                  password: password.text,
                );

                /// Update user's name
                await userCredential.user!.updateDisplayName(name.text);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  _showAlertDialog('Password is too weak.', context);
                } else if (e.code == 'email-already-in-use') {
                  _showAlertDialog('Email is already used.', context);
                }
              } catch (e) {
                _showAlertDialog('Something went wrong:\n$e', context);
              }
            }
          },
        ),
      ],
    );
  }

  void _showAlertDialog(String message, BuildContext context) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: Text(message),
      ),
    );
  }
}
