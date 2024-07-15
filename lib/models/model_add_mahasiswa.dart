// To parse this JSON data, do
//
//     final modelAddMahasiswa = modelAddMahasiswaFromJson(jsonString);

import 'dart:convert';

ModelAddMahasiswa modelAddMahasiswaFromJson(String str) => ModelAddMahasiswa.fromJson(json.decode(str));

String modelAddMahasiswaToJson(ModelAddMahasiswa data) => json.encode(data.toJson());

class ModelAddMahasiswa {
  bool isSuccess;
  String message;

  ModelAddMahasiswa({
    required this.isSuccess,
    required this.message,
  });

  factory ModelAddMahasiswa.fromJson(Map<String, dynamic> json) => ModelAddMahasiswa(
    isSuccess: json["isSuccess"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
  };
}