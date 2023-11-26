import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend_data_penjualan/constan.dart';
import 'package:frontend_data_penjualan/widget/item_trx.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
    required this.search,
  });

  final String search;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String order = "nama_barang";
  String sort = "asc";

  Future getSearch() async {
    String url = '${baseApiUrl}transaksi-search-and-sort';
    Map form = {
      "search": widget.search,
      "sort": sort,
      "order": order,
    };
    var response = await http.post(Uri.parse(url), body: form);
    // print(json.decode(response.body));
    return json.decode(response.body);
  }

  Future<bool> deleteTransaksi(int id) async {
    String url = '${baseApiUrl}transaksi-delete';
    var response = await http.post(Uri.parse(url), body: {'id': '$id'});
    // print(json.decode(response.body));
    var result = json.decode(response.body);

    return result['message'] == 'success';
  }

  sortName() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sorting Nama Barang'),
          content: SizedBox(
            height: 100,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      order = "nama_barang";
                      sort = "asc";
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Nama A-Z'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      order = "nama_barang";
                      sort = "desc";
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Nama Z-A'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  sortDate() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sorting Tanggal Transaksi'),
          content: SizedBox(
            height: 100,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      order = "tanggal_transaksi";
                      sort = "desc";
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Tanggal Transaksi dari Terbaru'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      order = "tanggal_transaksi";
                      sort = "asc";
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Tanggal Transaksi dari Terlama'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hasil pencarian '${widget.search}'",
          style: const TextStyle(color: Colors.white, fontSize: 10),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          InkWell(
            onTap: () {
              sortName();
            },
            child: const Icon(
              Icons.sort,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          InkWell(
            onTap: () {
              sortDate();
            },
            child: const Icon(
              Icons.date_range,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: FutureBuilder(
        future: getSearch(),
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
                    setState(() {});
                  },
                  namaBarang: item['nama_barang'],
                  jenisBarang: item['jenis_barang'],
                  stok: item['stok'].toString(),
                  jumlahTerjual: item['jumlah_terjual'].toString(),
                  tglTransaksi: item['tanggal_transaksi'].toString(),
                  id: item['id'],
                );
              },
            );
          } else {
            return const Text("Error");
          }
        },
      ),
    );
  }
}
