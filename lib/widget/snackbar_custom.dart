import 'package:flutter/material.dart';

showSnackBarCustom(bool value, BuildContext context, String action) {
  String msg = 'Gagal $action';
  if (value) {
    msg = "Berhasil $action";
  }

  var snackBar = SnackBar(
    content: Text(
      msg,
      style: const TextStyle(fontSize: 13),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
