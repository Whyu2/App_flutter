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
                shape: RoundedRectangleBorder(
                  //<-- SEE HERE
                  side: BorderSide(
                    color: Color.fromARGB(255, 143, 143, 143),
                  ),
                ),
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
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
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
                          margin: const EdgeInsets.only(
                              left: 10.0, top: 10, bottom: 10),
                          child: Text(
                            "Diajukan : " + _get[index]['created_by_nama'],
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child:
                                          Icon(Icons.location_city, size: 25),
                                    ),
                                    TextSpan(
                                      text: " Kota Asal",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: _get[index]['lokasi_asal'],
                                      
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15,),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                        child: Column(
                                      children: [
                                        Text(
                                            "(" +
                                                _get[index]['jarak']
                                                    ?.replaceFirst(
                                                        RegExp(r"\.[^]*"), "") +
                                                " KM" +
                                                ")",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10))
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child:
                                          Icon(Icons.location_city, size: 20),
                                    ),
                                    TextSpan(
                                      
                                      text: " Kota Tujuan",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: _get[index]['lokasi_tujuan'],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
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
                                  // TextSpan(
                                  //   text: " Tanggal : ",
                                  //   style: TextStyle(color: Colors.black),
                                  // ),
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
                            " " + _get[index]['tanggal_berangkat'],
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 1,
                            right: 1,
                            bottom: 10.0,
                            top: 5.0,
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Text("-"),
                                ),
                              ],
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
                            " " + _get[index]['tanggal_pulang'],
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 0,
                            bottom: 10.0,
                            top: 5.0,
                          ),
                          child: Text(
                            " (" + _get[index]['lama_hari'] + " Hari" + ")",
                            style: TextStyle(fontSize: 10, color: Colors.black),
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
                                    child: Icon(Icons.money, size: 20),
                                  ),
                                  TextSpan(
                                      text: " " +
                                          formatter.format(int.parse(
                                              _get[index]['uang_saku'])),
                                      style: TextStyle(color: Colors.black)),
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
                              bottom: 30.0,
                            ),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.sticky_note_2_outlined,
                                        size: 20),
                                  ),
                                  TextSpan(
                                      text: " " + _get[index]['maksud'],
                                      style: TextStyle(color: Colors.black)
                                      //         " KM",
                                      ),
                                ],
                              ),
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // elevation: 10.0,
                                backgroundColor:
                                    Color.fromARGB(255, 0, 67, 249),
                                onPrimary: Colors.white,
                                minimumSize: Size(300, 40), //////// HERE
                              ),

                              // style: ButtonStyle(
                              // backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 0, 0)),
                              // ),
                              onPressed: () async {
                                SharedPreferences localStorage =
                                    await SharedPreferences.getInstance();
                                // localStorage.setString('token', json.encode(body['token']));
                                localStorage.setString(
                                  'nrp_pegawai',
                                  _get[index]['nrp'],
                                );
                                localStorage.setString(
                                    'lokasi_asal', _get[index]['lokasi_asal']);
                                localStorage.setString('nama_pegawai',
                                    _get[index]['nama_pegawai']);
                                localStorage.setString('lokasi_id_asal',
                                    _get[index]['lokasi_id_asal']);
                                localStorage.setString('lokasi_tujuan',
                                    _get[index]['lokasi_tujuan']);
                                localStorage.setString('lokasi_id_tujuan',
                                    _get[index]['lokasi_id_tujuan']);
                                localStorage.setString('tanggal_berangkat',
                                    _get[index]['tanggal_berangkat']);
                                localStorage.setString('tanggal_pulang',
                                    _get[index]['tanggal_pulang']);
                                localStorage.setString(
                                    'maksud', _get[index]['maksud']);
                                localStorage.setString(
                                    'id_perdin', _get[index]['id']);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyEdit()));
                              },
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(Icons.save_alt, size: 20),
                                    ),
                                    TextSpan(
                                      text: " Edit",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      //         " KM",
                                    ),
                                  ],
                                ),
                              ),

                              //other properties
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // elevation: 10.0,
                                backgroundColor:
                                    Color.fromARGB(255, 255, 16, 16),
                                onPrimary: Colors.white,
                                minimumSize: Size(300, 40), //////// HERE
                              ),

                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
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
                                        deletePerdin(
                                            (_get[index]['id']).toString());
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Ok'),
                                    ),
                                  ],
                                ),
                              ),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(Icons.delete, size: 20),
                                    ),
                                    TextSpan(
                                      text: " Hapus",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      //         " KM",
                                    ),
                                  ],
                                ),
                              ),

                              //other properties
                            ),
                            SizedBox(height: 5),
                          ],
                        )
                      ],
                    )

                    // Row(children: [
                    //   Container(
                    //     margin: const EdgeInsets.only(
                    //       left: 10.0,
                    //       bottom: 10.0,
                    //     ),

                    //     child:

                    //     CircleAvatar(
                    //         radius: 20,
                    //         backgroundColor: Color.fromARGB(255, 0, 67, 249),
                    //         child: IconButton(
                    //             color: Colors.white,
                    //             onPressed: () async {
                    //               SharedPreferences localStorage =
                    //                   await SharedPreferences.getInstance();
                    //               // localStorage.setString('token', json.encode(body['token']));
                    //               localStorage.setString(
                    //                 'nrp_pegawai',
                    //                 _get[index]['nrp'],
                    //               );
                    //               localStorage.setString('lokasi_asal',
                    //                   _get[index]['lokasi_asal']);
                    //               localStorage.setString('nama_pegawai',
                    //                   _get[index]['nama_pegawai']);
                    //               localStorage.setString('lokasi_id_asal',
                    //                   _get[index]['lokasi_id_asal']);
                    //               localStorage.setString('lokasi_tujuan',
                    //                   _get[index]['lokasi_tujuan']);
                    //               localStorage.setString('lokasi_id_tujuan',
                    //                   _get[index]['lokasi_id_tujuan']);
                    //               localStorage.setString('tanggal_berangkat',
                    //                   _get[index]['tanggal_berangkat']);
                    //               localStorage.setString('tanggal_pulang',
                    //                   _get[index]['tanggal_pulang']);
                    //               localStorage.setString(
                    //                   'maksud', _get[index]['maksud']);
                    //               localStorage.setString(
                    //                   'id_perdin', _get[index]['id']);
                    //               Navigator.pushReplacement(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                       builder: (context) => MyEdit()));
                    //             },
                    //             icon: const Icon(Icons.edit))),
                    //   ),
                    //   Container(
                    //     margin: const EdgeInsets.only(
                    //       left: 10.0,
                    //       bottom: 10.0,
                    //     ),
                    //     child: CircleAvatar(
                    //         radius: 20,
                    //         backgroundColor: Colors.red,
                    //         child: IconButton(
                    //             color: Colors.white,
                    //             onPressed: () => showDialog<String>(
                    //                   context: context,
                    //                   builder: (BuildContext context) =>
                    //                       AlertDialog(
                    //                     title: const Text('Hapus'),
                    //                     content: const Text('Yakin Hapus ?'),
                    //                     actions: <Widget>[
                    //                       TextButton(
                    //                         onPressed: () =>
                    //                             Navigator.pop(context, 'Batal'),
                    //                         child: const Text('Batal'),
                    //                       ),
                    //                       TextButton(
                    //                         onPressed: () {
                    //                           deletePerdin((_get[index]['id'])
                    //                               .toString());
                    //                           Navigator.pop(context);
                    //                         },
                    //                         child: const Text('Ok'),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //             icon: const Icon(Icons.delete))),
                    //   ),
                    // ]),
                  ],
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            add_perdin();
          },
          backgroundColor: Color.fromARGB(255, 1, 1, 1),
          child: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(Icons.add, size: 25),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('name');
    localStorage.remove('id');
    localStorage.remove('nrp_pegawai');
    localStorage.remove('nama_pegawai');
    localStorage.remove('lokasi_asal');
    localStorage.remove('lokasi_tujuan');
    localStorage.remove('tanggal_berangkat');
    localStorage.remove('tanggal_pulang');
    localStorage.remove('maksud');
    localStorage.remove('id_perdin');
    localStorage.remove('lat1');
    localStorage.remove('lon1');
    localStorage.remove('lon2');
    localStorage.remove('lat2');
    localStorage.remove('lokasi_id_asal');
    localStorage.remove('lokasi_id_tujuan');
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
