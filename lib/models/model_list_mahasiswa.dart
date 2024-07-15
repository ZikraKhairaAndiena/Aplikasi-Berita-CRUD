// To parse this JSON data, do
//
//     final modelListMahasiswa = modelListMahasiswaFromJson(jsonString);

import 'dart:convert';

ModelListMahasiswa modelListMahasiswaFromJson(String str) => ModelListMahasiswa.fromJson(json.decode(str));

String modelListMahasiswaToJson(ModelListMahasiswa data) => json.encode(data.toJson());

class ModelListMahasiswa {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelListMahasiswa({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelListMahasiswa.fromJson(Map<String, dynamic> json) => ModelListMahasiswa(
    isSuccess: json["isSuccess"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String nama_mahasiswa;
  String nobp;
  String email;
  String jenis_kelamin;

  Datum({
    required this.id,
    required this.nama_mahasiswa,
    required this.nobp,
    required this.email,
    required this.jenis_kelamin,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    nama_mahasiswa: json["nama_mahasiswa"],
    nobp: json["nobp"],
    email: json["email"],
    jenis_kelamin: json["jenis_kelamin"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_mahasiswa": nama_mahasiswa,
    "nobp": nobp,
    "email": email,
    "jenis_kelamin": jenis_kelamin,
  };
}