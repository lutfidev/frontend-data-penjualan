import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_data_penjualan/constan.dart';
import 'package:frontend_data_penjualan/home.dart';
import 'package:frontend_data_penjualan/widget/snackbar_custom.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController namaBarangEdt = TextEditingController();

  final TextEditingController jenisBarangEdt = TextEditingController();

  final TextEditingController stokEdt = TextEditingController();

  final TextEditingController jumlahTerjualEdt = TextEditingController();

  final TextEditingController tglTranskasiEdt = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<bool> postData() async {
    String url = '${baseApiUrl}transaksi-add';
    Map form = {
      "nama_barang": namaBarangEdt.text,
      "jenis_barang": jenisBarangEdt.text,
      "stok": stokEdt.text,
      "jumlah_terjual": jumlahTerjualEdt.text,
      "tanggal_transaksi": tglTranskasiEdt.text,
    };
    var response = await http.post(Uri.parse(url), body: form);

    print(response.body);

    var result = json.decode(response.body);

    return result['message'] == 'success';
  }

  @override
  void dispose() {
    namaBarangEdt.dispose();
    jenisBarangEdt.dispose();
    stokEdt.dispose();
    jumlahTerjualEdt.dispose();
    tglTranskasiEdt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tambah Data Penjualan",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: namaBarangEdt,
                  decoration: const InputDecoration(
                    labelText: 'Nama Barang',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: jenisBarangEdt,
                  decoration: const InputDecoration(
                    labelText: 'Jenis Barang',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: stokEdt,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Stok',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: jumlahTerjualEdt,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Jumlah Terjual',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                  controller: tglTranskasiEdt,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Transaksi',
                  ),
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

                      setState(() {
                        tglTranskasiEdt.text = formattedDate;
                      });
                    } else {
                      // print("Date is not selected");
                    }
                  },
                ),
                const SizedBox(height: 20.0),

                // Submit Button
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                    Colors.green,
                  )),
                  onPressed: () {
                    // Form submission logic goes here
                    if (_formKey.currentState!.validate()) {
                      postData().then((value) {
                        showSnackBarCustom(value, context, 'disimpan');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ));
                      });
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
