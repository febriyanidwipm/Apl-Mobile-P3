import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(LatihanApi());
}

class LatihanApi extends StatefulWidget {
  const LatihanApi({super.key});

  @override
  State<LatihanApi> createState() => _LatihanApiState();
}

class _LatihanApiState extends State<LatihanApi> {
  var data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final apiUrl = "http://localhost/LatihanApi/data.php"; // URL API PHP

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final ready = json.decode(response.body);
      setState(() {
        data = List<Map<String, dynamic>>.from(ready);
        print(data);
      });
    } else {
      print("Gagal mengambil data dari API.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Latihan API'),
        ),
        body: Center(
          child: data.isNotEmpty
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return Column(
                      children: <Widget>[
                        Image.network(item["image"]),
                        Text(item["id"]),
                        Text(item["product"]),
                        Text(item["description"]),
                      ],
                    );
                  },
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
