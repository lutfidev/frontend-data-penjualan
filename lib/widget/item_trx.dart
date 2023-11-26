import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend_data_penjualan/constan.dart';
import 'package:frontend_data_penjualan/edit_page.dart';
import 'package:frontend_data_penjualan/widget/dialog_delete.dart';
import 'package:frontend_data_penjualan/widget/snackbar_custom.dart';
import 'package:http/http.dart' as http;

Widget itemTrx(
  BuildContext context,
  Function() setState,
  Function() refreshState, {
  int id = 0,
  String namaBarang = '',
  String jenisBarang = '',
  String stok = '',
  String jumlahTerjual = '',
  String tglTransaksi = '',
}) {
  Future<bool> deleteTransaksi(int id) async {
    String url = '${baseApiUrl}transaksi-delete';
    var response = await http.post(Uri.parse(url), body: {'id': '$id'});
    print(response.body);

    var result = json.decode(response.body);

    return result['message'] == 'success';
  }

  return Card(
      child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Nama Barang",
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          namaBarang,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Jenis Barang",
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          jenisBarang,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Stok",
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          stok,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Jumlah Terjual",
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          jumlahTerjual,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Tanggal Transaksi",
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          tglTransaksi,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute<String>(
                          builder: (context) => EditPage(
                            id: '$id',
                            namaBarangEdt: namaBarang,
                            jenisBarangEdt: jenisBarang,
                            stokEdt: stok,
                            jumlahTerjualEdt: jumlahTerjual,
                            tglTranskasiEdt: tglTransaksi,
                          ),
                        )).then((_) {
                      refreshState();
                    });
                  },
                  child: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    dialogDelete(
                        context,
                        () => deleteTransaksi(id).then((value) {
                              setState();
                              showSnackBarCustom(value, context, 'dihapus');
                            }));
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ));
}
