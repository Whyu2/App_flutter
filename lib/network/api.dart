import 'dart:convert';
import 'package:first_1/models/perdin.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class Network {
  final String _url = 'http://libra.akhdani.net:54125/api';

  auth(data, apiURL) async {
    var fullUrl = _url + apiURL;
    return await http.post(fullUrl, body: data);
  }

  postPerdin(data, apiURL) async {
    var fullUrl = _url + apiURL;
    return await http.post(fullUrl, body: data);
  }

  editPerdin(data, apiURL) async {
    var fullUrl = _url + apiURL;
    return await http.put(fullUrl, body: data);
  }

  deletePerdin(apiURL) async {
    var fullUrl = _url + apiURL;
    return await http.delete(fullUrl);
  }

  getPerdin(apiURL) async {
    var fullUrl = _url + apiURL;
    return await http.get(fullUrl);
  }

  getPegawai(apiURL) async {
    var fullUrl = _url + apiURL;
    return await http.get(fullUrl);
  }

  getKota(apiURL) async {
    var fullUrl = _url + apiURL;
    return await http.get(fullUrl);
  }

  getKota_byId(apiURL) async {
    var fullUrl = _url + apiURL;
    return await http.get(fullUrl);
  }

  //dropdown

}
