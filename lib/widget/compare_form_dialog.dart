import 'package:flutter/material.dart';
import 'package:frontend_data_penjualan/compare_page.dart';
import 'package:intl/intl.dart';

Future<void> showMyDialogCompare(BuildContext context) async {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Bandingkan jenis barang'),
        content: SizedBox(
          height: 300,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                  controller: startDateController,
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Mulai',
                  ),
                  cursorColor: Colors.black,
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1922),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);

                      startDateController.text = formattedDate;
                    } else {
                      // print("Date is not selected");
                    }
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Akhir',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                  controller: endDateController,
                  cursorColor: Colors.black,
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1922),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);

                      endDateController.text = formattedDate;
                    } else {
                      // print("Date is not selected");
                    }
                  },
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
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
              if (formKey.currentState!.validate()) {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComparePage(
                      startDate: startDateController.text,
                      endDate: endDateController.text,
                    ),
                  ),
                );
              }
            },
            child: const Text('Cari'),
          ),
        ],
      );
    },
  );
}
