// To parse this JSON data, do
//
//     final kota = kotaFromJson(jsonString);

import 'dart:convert';

Kota kotaFromJson(String str) => Kota.fromJson(json.decode(str));

String kotaToJson(Kota data) => json.encode(data.toJson());

class Kota {
    Kota({
      required  this.provinsi,
      required  this.kabkota,
      required  this.isactive,
      required  this.createdAt,
      required  this.lon,
      required  this.deletedAt,
      required  this.nama,
      required  this.negara,
      required  this.updatedAt,
      required  this.pulau,
      required  this.id,
      required  this.isln,
      required  this.lat,
    });

    String provinsi;
    String kabkota;
    String isactive;
    DateTime createdAt;
    String lon;
    dynamic deletedAt;
    String nama;
    String negara;
    dynamic updatedAt;
    String pulau;
    String id;
    String isln;
    String lat;

    factory Kota.fromJson(Map<String, dynamic> json) => Kota(
        provinsi: json["provinsi"],
        kabkota: json["kabkota"],
        isactive: json["isactive"],
        createdAt: DateTime.parse(json["created_at"]),
        lon: json["lon"],
        deletedAt: json["deleted_at"],
        nama: json["nama"],
        negara: json["negara"],
        updatedAt: json["updated_at"],
        pulau: json["pulau"],
        id: json["id"],
        isln: json["isln"],
        lat: json["lat"],
    );

    Map<String, dynamic> toJson() => {
        "provinsi": provinsi,
        "kabkota": kabkota,
        "isactive": isactive,
        "created_at": createdAt.toIso8601String(),
        "lon": lon,
        "deleted_at": deletedAt,
        "nama": nama,
        "negara": negara,
        "updated_at": updatedAt,
        "pulau": pulau,
        "id": id,
        "isln": isln,
        "lat": lat,
    };
}
