
// To parse this JSON data, do
//
//     final modelUpdateMahasiswa = modelUpdateMahasiswaFromJson(jsonString);

import 'dart:convert';

ModelUpdateMahasiswa modelUpdateMahasiswaFromJson(String str) => ModelUpdateMahasiswa.fromJson(json.decode(str));

String modelUpdateMahasiswaToJson(ModelUpdateMahasiswa data) => json.encode(data.toJson());

class ModelUpdateMahasiswa {
  bool isSuccess;
  int value;
  String message;
  String namaMahasiswa;
  String noBp;
  String jenisKelamin;
  String email;
  String id;

  ModelUpdateMahasiswa({
    required this.isSuccess,
    required this.value,
    required this.message,
    required this.namaMahasiswa,
    required this.noBp,
    required this.jenisKelamin,
    required this.email,
    required this.id,
  });

  factory ModelUpdateMahasiswa.fromJson(Map<String, dynamic> json) => ModelUpdateMahasiswa(
    isSuccess: json["is_success"],
    value: json["value"],
    message: json["message"],
    namaMahasiswa: json["nama_mahasiswa"],
    noBp: json["no_bp"],
    jenisKelamin: json["jenis_kelamin"],
    email: json["email"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "is_success": isSuccess,
    "value": value,
    "message": message,
    "nama_mahasiswa": namaMahasiswa,
    "no_bp": noBp,
    "jenis_kelamin": jenisKelamin,
    "email": email,
    "id": id,
  };
}
