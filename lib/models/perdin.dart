// To parse this JSON data, do
//
//     final perdin = perdinFromJson(jsonString);

import 'dart:convert';

Perdin perdinFromJson(String str) => Perdin.fromJson(json.decode(str));

String perdinToJson(Perdin data) => json.encode(data.toJson());

class Perdin {
  Perdin({
    required this.lokasiIdTujuan,
    required this.maksud,
    required this.jarak,
    required this.createdByNama,
    required this.createdAt,
    required this.uangSaku,
    required this.lokasiAsal,
    required this.nrp,
    required this.createdByUserId,
    required this.tanggalPulang,
    required this.lamaHari,
    required this.lokasiIdAsal,
    required this.namaPegawai,
    required this.updatedAt,
    required this.nipPegawai,
    required this.tanggalBerangkat,
    required this.id,
    required this.lokasiTujuan,
  });

  String lokasiIdTujuan;
  String maksud;
  String jarak;
  String createdByNama;
  DateTime createdAt;
  String uangSaku;
  String lokasiAsal;
  String nrp;
  String createdByUserId;
  DateTime tanggalPulang;
  String lamaHari;
  String lokasiIdAsal;
  String namaPegawai;
  DateTime updatedAt;
  String nipPegawai;
  DateTime tanggalBerangkat;
  String id;
  String lokasiTujuan;

  factory Perdin.fromJson(Map<String, dynamic> json) => Perdin(
        lokasiIdTujuan: json["lokasi_id_tujuan"],
        maksud: json["maksud"],
        jarak: json["jarak"],
        createdByNama: json["created_by_nama"],
        createdAt: DateTime.parse(json["created_at"]),
        uangSaku: json["uang_saku"],
        lokasiAsal: json["lokasi_asal"],
        nrp: json["nrp"],
        createdByUserId: json["created_by_user_id"],
        tanggalPulang: DateTime.parse(json["tanggal_pulang"]),
        lamaHari: json["lama_hari"],
        lokasiIdAsal: json["lokasi_id_asal"],
        namaPegawai: json["nama_pegawai"],
        updatedAt: DateTime.parse(json["updated_at"]),
        nipPegawai: json["nip_pegawai"],
        tanggalBerangkat: DateTime.parse(json["tanggal_berangkat"]),
        id: json["id"],
        lokasiTujuan: json["lokasi_tujuan"],
      );

  Map<String, dynamic> toJson() => {
        "lokasi_id_tujuan": lokasiIdTujuan,
        "maksud": maksud,
        "jarak": jarak,
        "created_by_nama": createdByNama,
        "created_at": createdAt.toIso8601String(),
        "uang_saku": uangSaku,
        "lokasi_asal": lokasiAsal,
        "nrp": nrp,
        "created_by_user_id": createdByUserId,
        "tanggal_pulang":
            "${tanggalPulang.year.toString().padLeft(4, '0')}-${tanggalPulang.month.toString().padLeft(2, '0')}-${tanggalPulang.day.toString().padLeft(2, '0')}",
        "lama_hari": lamaHari,
        "lokasi_id_asal": lokasiIdAsal,
        "nama_pegawai": namaPegawai,
        "updated_at": updatedAt.toIso8601String(),
        "nip_pegawai": nipPegawai,
        "tanggal_berangkat":
            "${tanggalBerangkat.year.toString().padLeft(4, '0')}-${tanggalBerangkat.month.toString().padLeft(2, '0')}-${tanggalBerangkat.day.toString().padLeft(2, '0')}",
        "id": id,
        "lokasi_tujuan": lokasiTujuan,
      };
}
