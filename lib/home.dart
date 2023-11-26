import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend_data_penjualan/add_page.dart';
import 'package:frontend_data_penjualan/constan.dart';
import 'package:frontend_data_penjualan/widget/compare_form_dialog.dart';
import 'package:frontend_data_penjualan/widget/item_trx.dart';
import 'package:frontend_data_penjualan/widget/search_form_dialog.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future getTransaksi() async {
    String url = '${baseApiUrl}transaksi-list';
    var response = await http.post(Uri.parse(url));
    // print(json.decode(response.body));
    return json.decode(response.body);
  }

  refreshState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Data Penjualan",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          InkWell(
            onTap: () {
              showMyDialogCompare(context);
            },
            child: const Icon(
              Icons.compare,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          InkWell(
            onTap: () {
              showMyDialogSearch(context);
            },
            child: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: FutureBuilder(
        future: getTransaksi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: snapshot.data['data'].length,
              itemBuilder: (context, index) {
                var item = snapshot.data['data'][index];
                return itemTrx(
                  context,
                  () {
                    setState(() {});
                  },
                  () {
                    refreshState();
                  },
                  namaBarang: item['barang']['nama_barang'],
                  jenisBarang: item['barang']['jenis_barang'],
                  stok: item['transaksi']['stok'].toString(),
                  jumlahTerjual: item['transaksi']['jumlah_terjual'].toString(),
                  tglTransaksi:
                      item['transaksi']['tanggal_transaksi'].toString(),
                  id: item['id'],
                );
              },
            );
          } else {
            return const Text("Error");
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddPage(),
              )).then((value) => getTransaksi());
        },
      ),
    );
  }
}
