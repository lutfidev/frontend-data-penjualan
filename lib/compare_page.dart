import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend_data_penjualan/constan.dart';
import 'package:frontend_data_penjualan/widget/compare_form_dialog.dart';
import 'package:frontend_data_penjualan/widget/search_form_dialog.dart';
import 'package:http/http.dart' as http;

class ComparePage extends StatefulWidget {
  const ComparePage({
    super.key,
    required this.startDate,
    required this.endDate,
  });

  final String startDate;
  final String endDate;

  @override
  State<ComparePage> createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> {
  Future getCompareData() async {
    String url = '${baseApiUrl}transaksi-compare-sales';
    Map form = {
      "start_date": widget.startDate,
      "end_date": widget.endDate,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hasil Perbandingan Jenis Barang",
          style: TextStyle(color: Colors.white, fontSize: 10),
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
        future: getCompareData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          } else if (snapshot.hasData) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Transaksi jenis barang yang banyak terjual",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            snapshot.data['most_sold_item'] == null
                                ? ""
                                : snapshot.data['most_sold_item']
                                    ['nama_barang'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Total terjual",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            snapshot.data['most_sold_item'] == null
                                ? ""
                                : snapshot.data['most_sold_item']
                                    ['total_terjual'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Transaksi jenis barang yang sedikit terjual",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          snapshot.data['least_sold_item'] == null
                              ? ""
                              : snapshot.data['least_sold_item']['nama_barang'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Total terjual",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          snapshot.data['least_sold_item'] == null
                              ? ""
                              : snapshot.data['least_sold_item']
                                  ['total_terjual'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Text("Error");
          }
        },
      ),
    );
  }
}
