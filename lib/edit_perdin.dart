import 'dart:convert';
import 'package:first_1/models/pegawai.dart';
import 'package:first_1/models/pegawai.dart';
import 'package:first_1/models/kota.dart';
import 'home.dart';
import 'package:flutter/material.dart';
import 'package:first_1/network/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'dart:math' as Math;

class MyEdit extends StatefulWidget {
  const MyEdit({super.key});
  //  const MyEdit({Key? key}) : super(key: key);
  @override
  MyEditState createState() => MyEditState();
}

class MyEditState extends State<MyEdit> {
  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  late TextEditingController datepergiController = TextEditingController();
  late TextEditingController datepulangController = TextEditingController();
  final TextEditingController pegawaiController = TextEditingController();
  final TextEditingController kotaasalController = TextEditingController();
  final TextEditingController kotatujuanController = TextEditingController();
  // final maskudController = TextEditingController();
  late TextEditingController maskudController = TextEditingController();

  var id_perdin,
      nrp_pegawai,
      nama_pegawai,
      id_kota_asal,
      kota_asal,
      lat_kota_asal,
      lon_kota_asal,
      id_kota_tujuan,
      kota_tujuan,
      lat_kota_tujuan,
      lon_kota_tujuan,
      tglberangkat,
      tglpulang,
      maksud,
      post_user_id;

  @override
  void initState() {
    super.initState();
    datepergiController.text = '';
    datepulangController.text = '';
    localData();
  }

  localData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var val_id_post_user = localStorage.getString('id');
    var val_nrp_nama = localStorage.getString('nrp_pegawai');
    var val_nama_pegawai = localStorage.getString('nama_pegawai');
    var val_lokasi_asal = localStorage.getString('lokasi_asal');
    var val_id_lokasi_asal = localStorage.getString('lokasi_id_asal');
    var val_lokasi_tujuan = localStorage.getString('lokasi_tujuan');
    var val_id_lokasi_tujuan = localStorage.getString('lokasi_id_tujuan');
    var val_tanggal_berangkat = localStorage.getString('tanggal_berangkat');
    var val_tanggal_pulang = localStorage.getString('tanggal_pulang');
    var val_maksud = localStorage.getString('maksud');
    var val_id_perdin = localStorage.getString('id_perdin');
    setState(() {
      id_perdin = val_id_perdin;
      nrp_pegawai = val_nrp_nama;
      nama_pegawai = val_nama_pegawai;
      id_kota_asal = val_id_lokasi_asal;
      kota_asal = val_lokasi_asal;
      id_kota_tujuan = val_id_lokasi_tujuan;
      kota_tujuan = val_lokasi_tujuan;
      datepergiController.text = val_tanggal_berangkat;
      datepulangController.text = val_tanggal_pulang;
      maskudController.text = val_maksud;
      post_user_id = val_id_post_user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              TextButton.icon(
                style: TextButton.styleFrom(
                  textStyle:
                      TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
                onPressed: () => {kembali()},
                icon: Icon(
                  Icons.arrow_circle_left,
                  color: Colors.white,
                ),
                label: Text(
                  'Kembali',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 0, 67, 249),
                        onPrimary: Colors.white,
                        minimumSize: Size(50, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ), // HERE
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          tambah();
                        }
                        // Provider.of(context, listen: false);
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(Icons.save_alt, size: 20),
                            ),
                            TextSpan(
                              text: " Simpan",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              //         " KM",
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(height: 20),
              DropdownSearch<Pegawai>(
                mode: Mode.MENU,
                label: "Pilih Pegawai",
                hint: "Daftar Pegawai",
                onFind: (text) async {
                  var response =
                      await Network().getPegawai('/master/pegawai/list');
                  if (response.statusCode != 200) {
                    print(response.statusCode);
                  }
                  List allPegawai = (json.decode(response.body)
                      as Map<String, dynamic>)["data"];
                  List<Pegawai> allNamaPegawawi = [];
                  allPegawai.forEach((element) {
                    allNamaPegawawi.add(Pegawai(
                      unitKerja: element["unitKerja"],
                      nama: element["nama"],
                      nip: element["nip"],
                      updatedAt: element["updatedAt"],
                      jabatan: element["jabatan"],
                      createdAt: element["createdAt"],
                      nrp: element["nrp"],
                      deletedAt: element["deletedAt"],
                      email: element["email"],
                      tanggalLahir: element["tanggalLahir"],
                    ));
                  });
                  return allNamaPegawawi;
                },
                popupItemBuilder: (context, item, isSelected) => ListTile(
                  title: Text(item.nama),
                ),
                dropdownBuilder: (context, selectedItem) => Text(
                  selectedItem?.nama ?? nama_pegawai,
                ),
                onChanged: (value) {
                  setState(() {
                    nrp_pegawai = value?.nrp;
                  });
                },
              ),
              //Data Pegawai
              //form username
              // DropdownSearch<dynamic>(
              //   mode: Mode.MENU,
              //   showSearchBox: true,
              //   onFind: (text) async {
              //     var response =
              //         await Network().getPegawai('/master/pegawai/list');
              //     if (response.statusCode != 200) {}
              //     List allPegawai = (json.decode(response.body)
              //         as Map<String, dynamic>)["data"];

              //     return allPegawai as List<dynamic>;
              //   },
              //   // onChanged: (value) => print(value['nrp']),
              //   onChanged: (value) => nrp_pegawai = value['nrp'],
              //   selectedItem: {"nama": nama_pegawai},
              //   itemAsString: ((item) => item['nama']),
              // ),
              SizedBox(height: 10),
              //Data Kota Asal
              DropdownSearch<Kota>(
                mode: Mode.MENU,
                label: "Pilih Kota Asal",
                hint: "Daftar Kota Asal",
                onFind: (text) async {
                  var response = await Network()
                      .getKota('/master/lokasi/list?limit=200&offset=0');
                  if (response.statusCode != 200) {
                    print(response.statusCode);
                  }
                  List allKotaasal = (json.decode(response.body)
                      as Map<String, dynamic>)["data"];
                  List<Kota> allNamaKota = [];
                  allKotaasal.forEach((element) {
                    allNamaKota.add(Kota(
                        provinsi: element["provinsi"],
                        kabkota: element["kabkota"],
                        isactive: element["isactive"],
                        createdAt: element["createdAt"],
                        lon: element["lon"],
                        deletedAt: element["deletedAt"],
                        nama: element["nama"],
                        negara: element["negara"],
                        updatedAt: element["updatedAt"],
                        pulau: element["pulau"],
                        id: element["id"],
                        isln: element["isln"],
                        lat: element["lat"]));
                  });
                  return allNamaKota;
                },
                popupItemBuilder: (context, item, isSelected) => ListTile(
                  title: Text(item.nama),
                ),
                dropdownBuilder: (context, selectedItem) => Text(
                  selectedItem?.nama ?? kota_asal,
                ),
                onChanged: (value) {
                  setState(() {
                    id_kota_asal = value?.id;
                    lat_kota_asal = value?.lat;
                    lon_kota_asal = value?.lon;
                  });
                },
              ),
              SizedBox(height: 10),
              //Data Kota Tujuan
              DropdownSearch<Kota>(
                mode: Mode.MENU,
                label: "Pilih Kota Tujuan",
                hint: "Daftar Kota Tujuan",
                onFind: (text) async {
                  var response = await Network()
                      .getKota('/master/lokasi/list?limit=200&offset=0');
                  if (response.statusCode != 200) {
                    print(response.statusCode);
                  }
                  List allKotaasal = (json.decode(response.body)
                      as Map<String, dynamic>)["data"];
                  List<Kota> allNamaKota = [];
                  allKotaasal.forEach((element) {
                    allNamaKota.add(Kota(
                        provinsi: element["provinsi"],
                        kabkota: element["kabkota"],
                        isactive: element["isactive"],
                        createdAt: element["createdAt"],
                        lon: element["lon"],
                        deletedAt: element["deletedAt"],
                        nama: element["nama"],
                        negara: element["negara"],
                        updatedAt: element["updatedAt"],
                        pulau: element["pulau"],
                        id: element["id"],
                        isln: element["isln"],
                        lat: element["lat"]));
                  });
                  return allNamaKota;
                },
                popupItemBuilder: (context, item, isSelected) => ListTile(
                  title: Text(item.nama),
                ),
                dropdownBuilder: (context, selectedItem) => Text(
                  selectedItem?.nama ?? kota_tujuan,
                ),
                onChanged: (value) {
                  setState(() {
                    id_kota_tujuan = value?.id;
                    lat_kota_tujuan = value?.lat;
                    lon_kota_tujuan = value?.lon;
                  });
                },
              ),
              SizedBox(height: 10),
              //Data Kota Tanggal Berangkat
              TextFormField(
                controller: datepergiController,
                decoration: new InputDecoration(
                  labelText: "Tanggl Berangkat ",
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                ),
                readOnly: true, // when true user cannot edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), //get today's date
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);

                    datepergiController.text = formattedDate.toString();
                  } else {
                    print("Tanggal Belum Di Pilih");
                  }
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Tanggal tidak boleh kosong';
                  }
                  tglberangkat = val;
                },
                onSaved: (val) {
                  datepergiController.text = val!;
                },
              ),
              SizedBox(height: 10),
              //Data Kota Tanggal Pulang
              TextFormField(
                controller: datepulangController,
                //editing controller of this TextField
                decoration: new InputDecoration(
                  labelText: "Tanggl Pulang ",
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                ),
                readOnly: true, // when true user cannot edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), //get today's date
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);

                    datepulangController.text = formattedDate.toString();
                  } else {
                    print("Tanggal Belum Di Pilih");
                  }
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Tanggal tidak boleh kosong';
                  }
                  tglpulang = val;
                },
                onSaved: (val) {
                  datepulangController.text = val!;
                },
              ),
              SizedBox(height: 10),
              //Data Maksud
              new TextFormField(
                controller: maskudController,

                minLines:
                    4, // any number you need (It works as the rows for the textarea)
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: new InputDecoration(
                  labelText: "Maksud",
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                ),
                validator: (maksudValue) {
                  if (maksudValue == null || maksudValue.isEmpty) {
                    return 'Maksud tidak boleh kosong';
                  }
                  maksud = maksudValue;
                },
                onSaved: (maksudValue) {
                  maskudController.text = maksudValue!;
                },
              ),
              SizedBox(height: 20),
            ]),
          ),
        ),
      ),
    );
  }

  void tambah() async {
    //hITUNG jARAKKK

    if (lat_kota_asal == null) {
      var response =
          await Network().getKota_byId('/master/lokasi/' + id_kota_asal);
      if (response.statusCode != 200) {
        print(response.statusCode);
      }
      var data = jsonDecode(response.body);
      lat_kota_asal = data["lat"];
      lon_kota_asal = data["lon"];
      id_kota_asal = data["id"];
    }

    if (lat_kota_tujuan == null) {
      var response =
          await Network().getKota_byId('/master/lokasi/' + id_kota_tujuan);
      if (response.statusCode != 200) {
        print(response.statusCode);
      }
      var data2 = jsonDecode(response.body);
      lat_kota_tujuan = data2["lat"];
      lon_kota_tujuan = data2["lon"];
      id_kota_tujuan = data2["id"];
    }

    var lat_asal = double.parse(lat_kota_asal);
    var lon_asal = double.parse(lon_kota_asal);

    var lat_tujuan = double.parse(lat_kota_tujuan);
    var lon_tujuan = double.parse(lon_kota_tujuan);

    double deg2rad(deg) {
      return deg * (Math.pi / 180);
    }

    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat_tujuan - lat_asal);
    var dLon = deg2rad(lon_tujuan - lon_asal);
    var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(deg2rad(lat_asal)) *
            Math.cos(deg2rad(lat_tujuan)) *
            Math.sin(dLon / 2) *
            Math.sin(dLon / 2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    var jarak = R * c; // Distance in km

    var jarak_km = jarak.toString();
    //Hitung durasi

    DateTime dt1 = DateTime.parse(tglpulang);
    DateTime dt2 = DateTime.parse(tglberangkat);

    Duration diff = dt1.difference(dt2);
    var durasi = diff.inDays + 1;

    var durasi_perdin = durasi.toString();
    //Uang saku
    var uang = "";
    if (jarak < 60) {
      uang = "0";
    } else if (jarak >= 60) {
      uang = "100000";
    }
    var uangsaku = int.parse(uang);
    var tot_uang = uangsaku * durasi;
    var tot_uangsaku = tot_uang.toString();

    var data = {
      'id': id_perdin,
      'nrp': nrp_pegawai,
      'lokasi_id_asal': id_kota_asal,
      'lokasi_id_tujuan': id_kota_tujuan,
      'jarak': jarak_km,
      'tanggal_berangkat': tglberangkat,
      'tanggal_pulang': tglpulang,
      'lama_hari': durasi_perdin,
      'maksud': maksud,
      'uang_saku': tot_uangsaku,
    };
    // print("nrp " + nrp_pegawai);
    // print("lokasi_id_asal " + id_kota_asal);
    // print("lokasi_id_tujuan " + id_kota_tujuan);
    // print("jarak " + jarak_km);
    // print("tanggal_berangkat " + tglberangkat);
    // print("tanggal_pulang " + tglpulang);
    // print("lama_hari " + durasi_perdin);
    // print("maskud " + maksud);
    // print("uang_saku " + tot_uangsaku);
    // print("created_by_user_id " + post_user_id);
    var response = await Network().editPerdin(data, '/trx/perdin/' + id_perdin);

    if (response.statusCode == 200) {
      AlertDialog alert = AlertDialog(
        content: Container(
          child: Text("Perdin Berhasil Diedit"),
        ),
        actions: [
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MyHome()));
            },
          ),
        ],
      );

      showDialog(context: context, builder: (context) => alert);
      return;
    } else {
      AlertDialog alert = AlertDialog(
        content: Container(
          child: Text("Perdin Gagal Diedit"),
        ),
        actions: [
          TextButton(
              child: Text('Ok'),
              onPressed: () =>
                  Navigator.of(context, rootNavigator: true).pop()),
        ],
      );
      showDialog(context: context, builder: (context) => alert);
      return;
    }
  }

  void kembali() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyHome()));
  }
}
