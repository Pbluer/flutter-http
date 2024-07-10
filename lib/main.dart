import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Endress {
  // ignore: prefer_typing_uninitialized_variables
  final cep;
  // ignore: prefer_typing_uninitialized_variables
  final logradouro;
  // ignore: prefer_typing_uninitialized_variables
  final unidade;
  // ignore: prefer_typing_uninitialized_variables
  final bairro;
  // ignore: prefer_typing_uninitialized_variables
  final uf;

  const Endress({required this.cep,
    required this.logradouro,
    required this.unidade,
    required this.bairro,
    required this.uf});

  factory Endress.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'cep': String cep,
      'logradouro': String logradouro,
      'unidade': String unidade,
      'bairro': String bairro,
      'uf': String uf,

      } =>
          Endress(
            cep: cep,
            logradouro: logradouro,
            unidade: unidade,
            bairro: bairro,
            uf: uf,
          ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

Future<http.Response> getUserAdress() async{
  final response = await http.get(Uri.parse('https://viacep.com.br/ws/21520820/json/'));
  print(response.body);
  return jsonDecode(response.body) ;
}

void main() => runApp(const MaterialApp(home: HomePage()));

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Endress> getEnddress;

  @override
  void initState(){
    super.initState();
    getEnddress = getUserAdress();
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: getEnddress,
        builder: (context,snapshot){
          print(snapshot);
          if( snapshot.hasData ){
            return Text('Foi');
          }else{
            return Text("${snapshot.error}");
          }
        }
    );
  }
}
