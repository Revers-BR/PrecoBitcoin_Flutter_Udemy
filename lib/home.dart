import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {

  const Home(
    {super.key}
  );

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  String _preco = "0";

  void _atualizarPreco() async {
    
    Uri url = Uri.https("blockchain.info","/ticker");

    http.Response response = await http.get(url);

    setState(() {
      
      _preco = jsonDecode(response.body)["BRL"]["buy"].toString();
    });
  }
  
  @override
  Widget build( BuildContext context ) {
    
    return Scaffold(

      body: Container(
       
        padding: const EdgeInsets.all(32),
        child: Column(

        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          Image.asset("imagens/bitcoin.png"),
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 32),
            child: Text(
            "R\$ " + _preco,
              style: const TextStyle(
                fontSize:20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          FilledButton(
            onPressed: _atualizarPreco, 
            child: const Text(
              "Atualizar"
            )
          )
        ],
      ),
      )
    );
  }
}
