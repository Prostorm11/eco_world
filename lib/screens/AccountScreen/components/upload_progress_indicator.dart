import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

Future<void> showUploadDialog(
    BuildContext context, ValueNotifier<double> progressNotifier) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text("Uploading..."),
        content: ValueListenableBuilder<double>(
          valueListenable: progressNotifier,
          builder: (context, progress, _) {
            if (progress >= 100.0) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(elevation: 2,
                backgroundColor: Colors.transparent,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Uploaded Successfully"),
                    ],
                  ),
                  duration: Duration(seconds: 5),
                ));
              });
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LinearProgressIndicator(value: progress / 100),
                const SizedBox(height: 10),
                Text('${progress.toStringAsFixed(1)}%'),
              ],
            );
          },
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Optional cancel
            },
            child: const Text("Cancel"),
          ),
        ],
      );
    },
  );
}
