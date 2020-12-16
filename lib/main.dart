import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/theme.dart';
import 'firebaseAuthDemo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase
      .initializeApp(); //wow app wont start until firebase is initialized
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // checkUserAlreadyLogin().then((isLogin) {
    //   if (isLogin == true) {
    //     print('Already login');
    //     Navigator.pushNamed(context, HomeScreen.routeName);
    //   } else {
    //     print('Not Login');
    //   }
    // });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: FirebaseAuthDemo(),
      title: 'Flutter Demo',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
//
// checkUserAlreadyLogin() async {
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   return _auth
//       .currentUser()
//       .then((user) => user != null ? true : false)
//       .catchError((onError) => false);
// }
