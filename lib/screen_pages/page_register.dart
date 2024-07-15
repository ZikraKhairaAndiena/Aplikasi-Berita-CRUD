import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uas_zikra_2037/screen_pages/page_login.dart';

import '../models/model_register.dart';

class PageRegisterNew extends StatefulWidget {
  const PageRegisterNew({Key? key}) : super(key: key);

  @override
  _PageRegisterNewState createState() => _PageRegisterNewState();
}

class _PageRegisterNewState extends State<PageRegisterNew> {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtNama = TextEditingController();
  TextEditingController txtNobp = TextEditingController();
  TextEditingController txtNohp = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtAlamat = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> registerAccount() async {
    setState(() {
      isLoading = true;
    });

    try {
      http.Response res = await http.post(
        Uri.parse('http://192.168.100.110/uas_mobile/register.php'),
        body: {
          "username": txtUsername.text,
          "nama": txtNama.text,
          "nobp": txtNobp.text,
          "nohp": txtNohp.text,
          "email": txtEmail.text,
          "alamat": txtAlamat.text,
          "password": txtPassword.text,
        },
      );

      print('Response from server: ${res.body}');
      print('Request body: ${{
        "username": txtUsername.text,
        "nama": txtNama.text,
        "nobp": txtNobp.text,
        "nohp": txtNohp.text,
        "email": txtEmail.text,
        "alamat": txtAlamat.text,
        "password": txtPassword.text,
      }}');

      if (res.statusCode == 200) {
        ModelRegister data = modelRegisterFromJson(res.body);

        if (data.value == 1) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${data.message}')),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const PageLogin()),
                (route) => false,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${data.message}')),
          );
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Register Form'),
      ),
      body: Form(
        key: keyForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: txtUsername,
                  validator: (val) => val!.isEmpty ? "Tidak Boleh Kosong" : null,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: txtNama,
                  validator: (val) => val!.isEmpty ? "Tidak Boleh Kosong" : null,
                  decoration: InputDecoration(
                    hintText: 'Nama',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: txtNobp,
                  validator: (val) => val!.isEmpty ? "Tidak Boleh Kosong" : null,
                  decoration: InputDecoration(
                    hintText: 'No BP',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: txtNohp,
                  validator: (val) => val!.isEmpty ? "Tidak Boleh Kosong" : null,
                  decoration: InputDecoration(
                    hintText: 'NO HP',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: txtEmail,
                  validator: (val) =>
                  val!.isEmpty ? "Tidak Boleh Kosong" : null,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: txtAlamat,
                  validator: (val) =>
                  val!.isEmpty ? "Tidak Boleh Kosong" : null,
                  decoration: InputDecoration(
                    hintText: 'Alamat',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: txtPassword,
                  validator: (val) =>
                  val!.isEmpty ? "Tidak Boleh Kosong" : null,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (keyForm.currentState!.validate()) {
                      registerAccount();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.orange,
                    minimumSize: Size(double.infinity, 45),
                  ),
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(width: 1, color: Colors.green),
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PageLogin()),
                  (route) => false,
            );
          },
          child: Text('Anda Sudah Punya Akun ? Silahkan Login'),
        ),
      ),
    );
  }
}
