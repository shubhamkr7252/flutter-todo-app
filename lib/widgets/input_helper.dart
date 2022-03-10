import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class InputHelper {
  static Widget textInput(BuildContext context,
      {required Widget prefixIcon,
      required String hint,
      required Function onValidate,
      required TextInputAction textInputAction,
      required TextEditingController textController,
      TextCapitalization? textCapitalization}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField(
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          textInputAction: textInputAction,
          decoration: InputDecoration(
              hintText: hint,
              prefixIcon: prefixIcon,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey[400]!,
                ),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!))),
          controller: textController,
          validator: (value) {
            return onValidate(value);
          }),
    );
  }

  static Widget passwordTextInput(BuildContext context,
      {required String hint,
      required Function onValidate,
      required bool hiddenText,
      Widget? prefixIcon,
      TextEditingController? textController,
      required TextInputAction textInputAction,
      required Function onSuffixButtonPressed}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField(
          obscureText: hiddenText,
          textInputAction: textInputAction,
          decoration: InputDecoration(
              suffixIcon: hiddenText == true
                  ? IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {
                        onSuffixButtonPressed();
                      })
                  : IconButton(
                      icon: const Icon(Icons.visibility_off),
                      onPressed: () {
                        onSuffixButtonPressed();
                      }),
              hintText: hint,
              prefixIcon: prefixIcon ?? const Icon(Icons.password),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey[400]!,
                ),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!))),
          controller: textController,
          validator: (value) {
            return onValidate(value);
          }),
    );
  }

  static Widget animatedButton(
      {required BuildContext context,
      required String buttonText,
      required RoundedLoadingButtonController buttonController,
      required Function onPressed}) {
    var pixelRatio = window.devicePixelRatio;
    return RoundedLoadingButton(
      borderRadius: 10,
      height: MediaQuery.of(context).size.width * .135,
      width: (window.physicalSize / pixelRatio).width,
      successColor: Theme.of(context).colorScheme.primary,
      failedIcon: Icons.error,
      color: Theme.of(context).colorScheme.primary,
      child: Text(buttonText),
      controller: buttonController,
      onPressed: () {
        onPressed();
      },
    );
  }
}
