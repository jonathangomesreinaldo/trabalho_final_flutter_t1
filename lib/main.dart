import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'clima.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: '',
    home: HomePage(),
  ));
}

Future<Clima> getClima() async {
  final String url = 'https://api.hgbrasil.com/weather?key=35b93269&city_name=Contagem,MG';

  final response = await http.get(url);
  if (response.statusCode == 200) {
    return Clima.fromJson(json.decode(response.body));
  } else {
    throw Exception('Erro No Carregamento Dos Dados');
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Clima & Tempo'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getClima(),
          // ignore: missing_return
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      snapshot.data.city,
                      style: TextStyle(fontSize: 30.0, color: Colors.white),
                    ),
                    Divider(),
                    Icon(
                      Icons.wb_sunny,
                      size: 150.0,
                      color: Colors.amber,
                    ),
                    Divider(),
                    Text(
                      snapshot.data.date,
                      style: TextStyle(fontSize: 30.0, color: Colors.white),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Text(
                        snapshot.data.condition,
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                    Divider(),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 90.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.wb_sunny,
                                size: 30.0,
                                color: Colors.amber,
                              ),
                              Text(
                                '   ${snapshot.data.temp.toString()} °C',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(left: 60.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.cloud,
                                size: 30.0,
                                color: Colors.white,
                              ),
                              Text(
                                '   ${snapshot.data.humidity.toString()}%',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}