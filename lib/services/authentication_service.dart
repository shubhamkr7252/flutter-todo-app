import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  static Future<String> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  static Future<String> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  static Future<String> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }
}
