import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
        String content, context) =>
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));

Future showDilogueBox(BuildContext context) => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );