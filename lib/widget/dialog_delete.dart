import 'package:flutter/material.dart';

Future<void> dialogDelete(BuildContext context, Function() action) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Hapus data?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Tutup'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              action();
            },
            child: const Text('Ya'),
          ),
        ],
      );
    },
  );
}
