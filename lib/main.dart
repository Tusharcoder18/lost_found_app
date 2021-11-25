import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lost_found_app/Models/Report.dart';
import 'package:lost_found_app/screens/item_detail_fullscreen.dart';
import 'package:lost_found_app/screens/sign_in.dart';
import 'package:lost_found_app/services/authentication_service.dart';
import 'package:lost_found_app/services/upload_service.dart';
import 'package:lost_found_app/theme/dark_theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider<User>(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
        Provider<UploadService>(create: (context) => UploadService()),
        Provider<Report>(create: (context) => Report()),
      ],
      child: MaterialApp(
        title: "Lost and Found",
        theme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: SignIn(),
      ),
    );
  }
}
