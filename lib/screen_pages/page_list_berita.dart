import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas_zikra_2037/screen_pages/page_detail_berita.dart';
import 'package:uas_zikra_2037/screen_pages/page_login.dart';

import '../models/model_berita.dart';
import '../utils/cek_session.dart';

class PageListBerita extends StatefulWidget {
  const PageListBerita({super.key});

  @override
  State<PageListBerita> createState() => _PageListBeritaState();
}

class _PageListBeritaState extends State<PageListBerita> {
  String? id, username;
  TextEditingController searchController = TextEditingController();
  List<Datum> beritaList = [];
  List<Datum> filteredBeritaList = [];

  Future<List<Datum>?> getBerita() async {
    try {
      http.Response res = await http.get(Uri.parse('http://192.168.100.110/uas_mobile/berita.php'));
      return modelBeritaFromJson(res.body).data;
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  Future getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id") ?? '';
      username = pref.getString("username") ?? '';
      print('id $id');
    });
  }

  @override
  void initState() {
    super.initState();
    getBerita().then((berita) {
      setState(() {
        beritaList = berita ?? [];
        filteredBeritaList = beritaList;
      });
    });
    getSession();
  }

  void filterSearchResults(String query) {
    List<Datum> dummySearchList = [];
    dummySearchList.addAll(beritaList);
    if (query.isNotEmpty) {
      List<Datum> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.judul.toLowerCase().contains(query.toLowerCase()) || item.konten.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        filteredBeritaList.clear();
        filteredBeritaList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        filteredBeritaList.clear();
        filteredBeritaList.addAll(beritaList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Berita'),
        backgroundColor: Colors.orange,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text('Hi.. $username')),
          ),
          IconButton(
            onPressed: () {
              session.clearSession();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PageLogin()), (route) => false);
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                filterSearchResults(value);
              },
              decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getBerita(),
              builder: (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: Colors.orange));
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("No data found"));
                } else {
                  return ListView.builder(
                    itemCount: filteredBeritaList.length,
                    itemBuilder: (context, index) {
                      Datum data = filteredBeritaList[index];
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PageDetailBerita(data)));
                          },
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      'http://192.168.100.110/uas_mobile/image/${data.gambar}',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    '${data.judul}',
                                    style: TextStyle(fontSize: 14, color: Colors.orange, fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${data.author}',
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 4), // Spacer
                                      Text(
                                        'Tanggal: ${data.created}',
                                        style: TextStyle(fontSize: 12, color: Colors.grey),
                                      ),
                                      SizedBox(height: 4), // Spacer
                                      Text(
                                        '${data.konten}',
                                        maxLines: 2,
                                        style: TextStyle(color: Colors.black54, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => PageDetailBerita(data)),
                                    );
                                  },
                                ),

                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
