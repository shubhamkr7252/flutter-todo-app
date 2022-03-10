import 'package:flutter/material.dart';
import 'package:todo_test_app/pages/signin.dart';
import 'package:todo_test_app/pages/signup.dart';
import 'package:todo_test_app/widgets/modal_sheet.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("TODO LIST"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/logo.png",
                    width: MediaQuery.of(context).size.width * .5),
                SizedBox(height: MediaQuery.of(context).size.width * .05),
                Text(
                  "Welcome to TODO LIST",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * .055,
                      letterSpacing: 2),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * .02),
                Text(
                  "Keep tracks of important things that you need to get done in one place.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * .037,
                  ),
                ),
              ],
            )),
            SizedBox(height: MediaQuery.of(context).size.height * .02),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * .135,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)))),
                  onPressed: () {
                    ModalSheet.bottomModalSheet(context, const SignUp());
                  },
                  child: const Text("Sign Up")),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .02),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * .135,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.secondary),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)))),
                  onPressed: () {
                    ModalSheet.bottomModalSheet(context, const SignIn());
                  },
                  child: const Text("Sign In")),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .035),
          ],
        ),
      ),
    );
  }
}
