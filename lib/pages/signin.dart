import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:todo_test_app/pages/home_screen.dart';
import 'package:todo_test_app/services/authentication_service.dart';
import 'package:todo_test_app/widgets/input_helper.dart';
import 'package:todo_test_app/widgets/toast_custom.dart';
import 'package:validators/validators.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _hiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _globalKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: MediaQuery.of(context).size.width * .02),
              const Center(child: Icon(Icons.drag_handle)),
              SizedBox(height: MediaQuery.of(context).size.width * .035),
              Text(
                "SIGN IN",
                textAlign: TextAlign.start,
                style: TextStyle(
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.of(context).size.width * .05,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width * .02),
              InputHelper.textInput(context,
                  textController: _emailController,
                  prefixIcon: const Icon(Icons.email),
                  hint: "Email", onValidate: (String value) {
                if (value.isEmpty) {
                  return "Please enter an email address.";
                }
                if (!isEmail(value)) {
                  return "Please enter a valid email address.";
                }
                return null;
              }, textInputAction: TextInputAction.next),
              InputHelper.passwordTextInput(context,
                  hint: "Password",
                  hiddenText: _hiddenPassword,
                  textController: _passwordController,
                  onValidate: (String value) {
                if (value.isEmpty) {
                  return "Please input a password.";
                } else if (value.length < 6) {
                  return "Password length should be more than 6 characters.";
                }
                return null;
              }, onSuffixButtonPressed: () {
                setState(() {
                  _hiddenPassword = !_hiddenPassword;
                });
              }, textInputAction: TextInputAction.done),
              const SizedBox(height: 20),
              InputHelper.animatedButton(
                  context: context,
                  buttonText: "Login",
                  buttonController: _btnController,
                  onPressed: () {
                    if (validataAndSave()) {
                      AuthenticationService.signIn(
                              _emailController.text, _passwordController.text)
                          .then((String result) {
                        if (result == "success") {
                          _btnController.success();
                          Future.delayed(const Duration(seconds: 2)).then(
                              (value) => Navigator.pushAndRemoveUntil(
                                  context,
                                  PageTransition(
                                      child: const HomeScreen(),
                                      type: PageTransitionType.fade),
                                  (route) => false));
                        } else {
                          CustomToast.errorToast(context, result);
                          _btnController.error();
                          Future.delayed(const Duration(seconds: 2))
                              .then((_) => _btnController.reset());
                        }
                      });
                    } else {
                      _btnController.reset();
                    }
                  }),
              SizedBox(height: MediaQuery.of(context).size.width * .055),
            ],
          ),
        ),
      ),
    );
  }

  bool validataAndSave() {
    final form = _globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
