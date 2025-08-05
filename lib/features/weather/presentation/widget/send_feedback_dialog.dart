import 'package:flutter/material.dart';

import '../../../../src/platform/native_service.dart';

void showFeedbackDialog(context) {
  final controller = TextEditingController();

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Send Feedback'),
      content: TextField(
        controller: controller,
        maxLines: 4,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: 'Enter your feedback...',
          enabledBorder: border(),
          border: border(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final String message = controller.text.trim();
            late final String snackBarMessage;
            if (message.isNotEmpty) {
              NativeService.sendFeedbackToNative(message);
              snackBarMessage = 'Feedback sent successfully';
              Navigator.pop(context);
            } else {
              snackBarMessage = 'Please enter a message';
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(snackBarMessage)),
            );
          },
          child: const Text('Send'),
        ),
      ],
    ),
  );
}

OutlineInputBorder border() => OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(
        color: Colors.transparent,
        width: 0,
      ),
    );
