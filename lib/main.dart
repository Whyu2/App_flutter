import 'dart:convert';
import 'home.dart';
import 'package:flutter/material.dart';
import 'package:first_1/network/api.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: const MyLoginForm(),
      ),
    );
  }
}

class MyLoginForm extends StatefulWidget {
  const MyLoginForm({super.key});

  @override
  MyLoginFormState createState() {
    return MyLoginFormState();
  }
}

class MyLoginFormState extends State<MyLoginForm> {
  final _formKey = GlobalKey<FormState>();
  var username, password;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(children: [
                SizedBox(height: 50),
                Text(
                  "Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40),
                //form username
                TextFormField(
                  decoration: new InputDecoration(
                    hintText: "Masukan Username ",
                    labelText: "Username",
                    icon: Icon(Icons.people),
                    border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0)),
                  ),
                  validator: (usernameValue) {
                    if (usernameValue == null || usernameValue.isEmpty) {
                      return 'Username tidak boleh kosong';
                    }
                    username = usernameValue;
                  },
                ),
                SizedBox(height: 20),
                //form username
                TextFormField(
                  decoration: new InputDecoration(
                    hintText: "Masukkan Password ",
                    labelText: "Password",
                    icon: Icon(Icons.key),
                    border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0)),
                  ),
                  validator: (passwordValue) {
                    if (passwordValue == null || passwordValue.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    password = passwordValue;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 67, 249),
                    onPrimary: Colors.white,
                    minimumSize: Size(300, 50), //////// HERE
                  ),
                  // style: ButtonStyle(
                  // backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 0, 0)),
                  // ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      login();
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //other properties
                ),
              ]),
            ),
          ),
        )
      ],
    );
  }

  void login() async {
    var data = {'username': username, 'password': password};
    var response = await Network().auth(data, '/auth/login');
    var body = json.decode(response.body);

    if (response.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      // localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('id', body['id']);
      localStorage.setString('name', body['nama']);
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(builder: (context) => MyHome()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username / password anda salah')),
      );
    }
  }
}
