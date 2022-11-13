// To parse this JSON data, do
//
//     final pegawai = pegawaiFromJson(jsonString);

import 'dart:convert';

Pegawai pegawaiFromJson(String str) => Pegawai.fromJson(json.decode(str));

String pegawaiToJson(Pegawai data) => json.encode(data.toJson());

class Pegawai {
    Pegawai({
      required  this.unitKerja,
      required  this.nama,
      required  this.nip,
      required  this.updatedAt,
      required  this.jabatan,
      required  this.createdAt,
      required  this.nrp,
      required  this.deletedAt,
      required  this.email,
      required  this.tanggalLahir,
    });

    String unitKerja;
    String nama;
    String nip;
    dynamic updatedAt;
    String jabatan;
    dynamic createdAt;
    String nrp;
    dynamic deletedAt;
    String email;
    DateTime tanggalLahir;

    factory Pegawai.fromJson(Map<String, dynamic> json) => Pegawai(
        unitKerja: json["unit_kerja"],
        nama: json["nama"],
        nip: json["nip"],
        updatedAt: json["updated_at"],
        jabatan: json["jabatan"],
        createdAt: json["created_at"],
        nrp: json["nrp"],
        deletedAt: json["deleted_at"],
        email: json["email"],
        tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
    );

    Map<String, dynamic> toJson() => {
        "unit_kerja": unitKerja,
        "nama": nama,
        "nip": nip,
        "updated_at": updatedAt,
        "jabatan": jabatan,
        "created_at": createdAt,
        "nrp": nrp,
        "deleted_at": deletedAt,
        "email": email,
        "tanggal_lahir": "${tanggalLahir.year.toString().padLeft(4, '0')}-${tanggalLahir.month.toString().padLeft(2, '0')}-${tanggalLahir.day.toString().padLeft(2, '0')}",
    };
}
