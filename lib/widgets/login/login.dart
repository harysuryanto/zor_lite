import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
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
          child: const Text('Login'),
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              try {
                /// Default value
                // await auth.signInWithEmailAndPassword(
                //   email: 'hary@novelin.com'.trim(),
                //   password: '123123123',
                // );

                /// Dynamic
                await auth.signInWithEmailAndPassword(
                  email: email.text.trim(),
                  password: password.text,
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  _showAlertDialog('User with that email not found.', context);
                } else if (e.code == 'wrong-password') {
                  _showAlertDialog('Wrong password.', context);
                }
              } catch (e) {
                _showAlertDialog('Something went wrong:\n$e.', context);
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
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }
}
