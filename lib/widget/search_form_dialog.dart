import 'package:flutter/material.dart';
import 'package:frontend_data_penjualan/search_page.dart';

Future<void> showMyDialogSearch(BuildContext context) async {
  TextEditingController textFieldController = TextEditingController();

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Pencarian'),
        content: TextFormField(
          controller: textFieldController,
          decoration: const InputDecoration(hintText: 'Cari nama barang...'),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Tutup'),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle the submit action here
              Navigator.of(context).pop();

              String enteredText = textFieldController.text;

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(search: enteredText),
                  ));
            },
            child: const Text('Cari'),
          ),
        ],
      );
    },
  );
}
