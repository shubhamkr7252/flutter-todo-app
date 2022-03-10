import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class CustomToast {
  static errorToast(BuildContext context, String text) {
    return BotToast.showAttachedWidget(
        attachedBuilder: (_) => Card(
              child: Container(
                  color: Theme.of(context).colorScheme.error,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Error Occurred",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      const SizedBox(height: 5),
                      Text(
                        text,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
            ),
        duration: const Duration(seconds: 2),
        target: const Offset(520, 520));
  }
}
