import 'dart:convert';

import 'package:first_1/edit_perdin.dart';
import 'package:flutter/material.dart';
import 'package:first_1/network/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'add_perdin.dart';

// import 'edit_perdin.dart';
import 'package:http/http.dart' as http;

class MyHome extends StatefulWidget {
  const MyHome({super.key});
  @override
  MyHomeState createState() => MyHomeState();
}

class MyHomeState extends State<MyHome> {
  var name = "";
  List _get = [];
  @override
  void initState() {
    super.initState();
    localData();
    listData();
  }

  localData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var names = localStorage.getString('name');
    setState(() {
      name = names;
    });
  }

  Future listData() async {
    var response =
        await Network().getPerdin('/trx/perdin/list?limit=1000&offset=0');
    // cek respon
    if (response.statusCode != 200) {
      print(response.statusCode);
    }

    var data = jsonDecode(response.body);

    setState(() {
      //memasukan data yang di dapat dari internet ke variabel _get
      _get = data['data'];
    });

    ;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/editPerdin': (context) => MyEdit(),
      },
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home Perdin'),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          actions: [
            TextButton.icon(
              style: TextButton.styleFrom(
                textStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
              onPressed: () => {logout()},
              icon: Icon(
                Icons.arrow_circle_right,
                color: Colors.white,
              ),
              label: Text(
                'Logout',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
        body: ListView.builder(
            itemCount: _get.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10.0, top: 10),
                          child: Text(
                            _get[index]['nama_pegawai'],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10.0, top: 5),
                          child: Text(
                            _get[index]['nip_pegawai'],
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10.0, top: 10),
                          child: Text(
                            "Diajukan Oleh : " + _get[index]['created_by_nama'],
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10.0, top: 10),
                          child: Text(
                            "Detail Perdin :",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 10.0, bottom: 10.0, top: 10),
                          child: Text(
                            "Kota Asal : " + _get[index]['lokasi_asal'],
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: 10.0,
                            bottom: 10.0,
                          ),
                          child: Text(
                            "Kota Tujuan : " + _get[index]['lokasi_tujuan'],
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: 10.0,
                            bottom: 10.0,
                          ),
                          child: Text(
                            "Tanggal : ",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 0,
                            bottom: 10.0,
                          ),
                          child: Text(
                            _get[index]['tanggal_berangkat'],
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 5,
                            right: 5,
                            bottom: 10.0,
                          ),
                          child: Text(
                            "-->",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 0,
                            bottom: 10.0,
                          ),
                          child: Text(
                            _get[index]['tanggal_pulang'],
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: 10.0,
                            bottom: 10.0,
                          ),
                          child: Text(
                            "Lama : " + _get[index]['lama_hari'] + " hari",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: 10.0,
                            bottom: 10.0,
                          ),
                          child: Text(
                            "Uang Saku : Rp." + _get[index]['uang_saku'],
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: 10.0,
                            bottom: 10.0,
                          ),
                          child: Text(
                            "Jarak : " + _get[index]['jarak'] + " KM",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: 10.0,
                            bottom: 10.0,
                          ),
                          child: Text(
                            "Maksud : " + _get[index]['maksud'],
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: 10.0,
                          bottom: 10.0,
                        ),
                        child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Color.fromARGB(255, 0, 67, 249),
                            child: IconButton(
                                color: Colors.white,
                                onPressed: () => Navigator.of(context)
                                        .popAndPushNamed('/editPerdin',
                                            arguments: [
                                          _get[index]['nama_pegawai'],
                                          _get[index]['nrp'],
                                          _get[index]['lokasi_asal'],
                                          _get[index]['lokasi_id_asal'],
                                          _get[index]['lokasi_tujuan'],
                                          _get[index]['lokasi_id_tujuan'],
                                          _get[index]['tanggal_berangkat'],
                                          _get[index]['tanggal_pulang'],
                                          _get[index]['maksud'],
                                          _get[index]['id'],
                                        ]),
                                icon: const Icon(Icons.edit))),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 10.0,
                          bottom: 10.0,
                        ),
                        child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.red,
                            child: IconButton(
                                color: Colors.white,
                                // onPressed: () {
                                //   deletePerdin((_get[index]['id']).toString());
                                //   print(_get[index]['id']);
                                // },
                                onPressed: () => showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Hapus'),
                                        content: const Text('Yakin Hapus ?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'Batal'),
                                            child: const Text('Batal'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              deletePerdin((_get[index]['id'])
                                                  .toString());
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Ok'),
                                          ),
                                        ],
                                      ),
                                    ),
                                icon: const Icon(Icons.delete))),
                      ),
                    ]),
                  ],
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            add_perdin();
          },
          backgroundColor: Color.fromARGB(255, 1, 1, 1),
          child: Text(
            "+",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  void logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('name');
    localStorage.remove('id');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyApp()));
  }

  void add_perdin() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyPerdinForm()));
  }

  void deletePerdin(String id) async {
    var response = await Network().deletePerdin('/trx/perdin/' + id);
    if (response.statusCode == 200) {
      print("Berhasil dihapus");
      listData();
    } else {
      print(response.statusCode);
    }
  }
}
