import 'dart:convert';

import 'package:first_1/edit_perdin.dart';
import 'package:flutter/material.dart';
import 'package:first_1/network/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'add_perdin.dart';
import 'package:intl/intl.dart';
// import 'edit_perdin.dart';

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

//format idr
  final formatter = NumberFormat.simpleCurrency(locale: 'id_ID');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/editPerdin': (context) => MyEdit(),
      },
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
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
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
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
                            "NIP Pegawai : " +
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
                          margin: const EdgeInsets.only(
                              left: 10.0, top: 10, bottom: 10),
                          child: Text(
                            "Detail Perdin :",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
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
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.location_city, size: 20),
                                  ),
                                  TextSpan(
                                    text: " Kota Tujuan : " +
                                        _get[index]['lokasi_asal'],
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(
                              left: 10.0,
                              bottom: 10.0,
                            ),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.location_city, size: 20),
                                  ),
                                  TextSpan(
                                    text: " Kota Tujuan : " +
                                        _get[index]['lokasi_tujuan'],
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(
                              left: 10.0,
                              bottom: 10.0,
                            ),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.date_range, size: 20),
                                  ),
                                  TextSpan(text: " Tanggal : "),
                                ],
                              ),
                            )),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 0,
                            bottom: 10.0,
                            top: 5.0,
                          ),
                          child: Text(
                            _get[index]['tanggal_berangkat'],
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 5,
                            right: 5,
                            bottom: 10.0,
                            top: 5.0,
                          ),
                          child: Text(
                            "-->",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 0,
                            bottom: 10.0,
                            top: 5.0,
                          ),
                          child: Text(
                            _get[index]['tanggal_pulang'],
                            style: TextStyle(
                              fontSize: 15,
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
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.lock_clock, size: 20),
                                  ),
                                  TextSpan(
                                    text: " Lama Hari : " +
                                        _get[index]['lama_hari'] +
                                        " Hari",
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(
                              left: 10.0,
                              bottom: 10.0,
                            ),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.money, size: 20),
                                  ),
                                  TextSpan(
                                    text: " Uang Saku : " +
                                        formatter.format(int.parse(
                                            _get[index]['uang_saku'])),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(
                              left: 10.0,
                              bottom: 10.0,
                            ),
                            child: 
                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.location_pin, size: 20),
                                  ),
                                  TextSpan(
                                      text: " Jarak : " +
                                          _get[index]['jarak']?.replaceFirst(
                                              RegExp(r"\.[^]*"), "") +
                                          " KM"
                                      //         " KM",
                                      ),
                                ],
                              ),
                            )
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
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.sticky_note_2_outlined,
                                        size: 20),
                                  ),
                                  TextSpan(
                                      text: " Maksud : " + _get[index]['maksud']
                                      //         " KM",
                                      ),
                                ],
                              ),
                            ))
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
