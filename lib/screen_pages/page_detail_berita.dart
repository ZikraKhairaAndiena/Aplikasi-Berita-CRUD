import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/model_berita.dart';

class PageDetailBerita extends StatelessWidget {

  //konstruktor penampung data
  final Datum? data;
  const PageDetailBerita(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(data!.judul),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'http://192.168.100.110/uas_mobile/image/${data?.gambar}',
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            title: Text(
              data?.judul ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Author: ${data?.author ?? ""}',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(height: 4),
                Text(
                  'Tanggal: ${DateFormat('dd MMMM yyyy').format(data?.created ?? DateTime.now())}',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            trailing: Icon(Icons.star, color: Colors.orange),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              data?.konten ?? "",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
