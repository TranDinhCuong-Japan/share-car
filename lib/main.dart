import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_stuff/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:share_stuff/services/auth.dart';
import 'firebase_options.dart';
import 'package:share_stuff/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: AuthService().user,
      catchError: (_, __) => null,
      initialData: null,
      child: const MaterialApp(
        home:  Wrapper(),
      ),
    );
  }
}
