import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_test_app/firebase_options.dart';
import 'package:todo_test_app/pages/home_screen.dart';
import 'package:todo_test_app/pages/welcome_page.dart';

Future<void> main() async {
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
    return MaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: ThemeMode.system,
      initialRoute: FirebaseAuth.instance.currentUser != null
          ? "/home_screen"
          : "/welcome_screen",
      routes: {
        "/welcome_screen": ((context) => const WelcomeScreen()),
        "/home_screen": ((context) => const HomeScreen()),
      },
    );
  }

  ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      inputDecorationTheme: const InputDecorationTheme(
          iconColor: Colors.black87,
          hintStyle: TextStyle(color: Colors.black38)),
      iconTheme: const IconThemeData(color: Colors.black87),
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: Colors.white),
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.black87,
            displayColor: Colors.black87,
          ),
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        toolbarHeight: 70,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          error: Colors.redAccent[100],
          primary: Colors.teal[500],
          secondary: Colors.brown[500],
          background: Colors.white),
    );
  }

  ThemeData darkThemeData(BuildContext context) {
    return ThemeData(
      cardColor: const Color.fromARGB(255, 35, 35, 35),
      drawerTheme: const DrawerThemeData(
          backgroundColor: Color.fromARGB(255, 20, 20, 20)),
      inputDecorationTheme: InputDecorationTheme(
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent[100]!),
          ),
          errorStyle: TextStyle(color: Colors.redAccent[100]),
          iconColor: Colors.white,
          hintStyle: const TextStyle(color: Colors.white54)),
      iconTheme: const IconThemeData(color: Colors.white),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color.fromARGB(255, 20, 20, 20)),
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
      backgroundColor: Colors.black87,
      scaffoldBackgroundColor: Colors.black87,
      appBarTheme: const AppBarTheme(
        toolbarHeight: 70,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          error: Colors.redAccent,
          primary: Colors.teal[500],
          secondary: Colors.brown[400],
          background: Colors.black87),
    );
  }
}
