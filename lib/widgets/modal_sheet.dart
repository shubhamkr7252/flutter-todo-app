import 'package:flutter/material.dart';

class ModalSheet {
  static Future<void> bottomModalSheet(BuildContext context, Widget dest) {
    return showModalBottomSheet(
        context: context,
        builder: (context) =>
            Padding(padding: MediaQuery.of(context).viewInsets, child: dest),
        isDismissible: false,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        )));
  }
}
