import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    return CupertinoButton(
      child: const Text('Login'),
      onPressed: () async {
        try {
          await auth.signInWithEmailAndPassword(
            email: 'hary@novelin.com'.trim(),
            password: '123123123',
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            _showAlertDialog(
                'Tidak tersedia akun dengan email tersebut.', context);
          } else if (e.code == 'wrong-password') {
            _showAlertDialog('Password salah.', context);
          }
        } catch (e) {
          _showAlertDialog('Terjadi kesalahan:\n$e.', context);
        }
      },
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
