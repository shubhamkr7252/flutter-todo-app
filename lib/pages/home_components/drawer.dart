import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_test_app/services/authentication_service.dart';
import 'package:todo_test_app/widgets/toast_custom.dart';

import '../welcome_page.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
            color: Theme.of(context).colorScheme.primary,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
                child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "SIGNED IN AS",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: MediaQuery.of(context).size.width * .025,
                            letterSpacing: 2),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        FirebaseAuth.instance.currentUser!.email.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * .05),
                      )
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    AuthenticationService.signOut().then(
                      (String result) {
                        if (result == "success") {
                          Navigator.pushAndRemoveUntil(
                              context,
                              PageTransition(
                                  child: const WelcomeScreen(),
                                  type: PageTransitionType.fade),
                              (route) => false);
                        } else {
                          CustomToast.errorToast(context, result);
                        }
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
