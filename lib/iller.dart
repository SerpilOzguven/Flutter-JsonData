import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_veritabani_uygulama/il.dart';
import 'package:json_veritabani_uygulama/ilce.dart';

class Iller extends StatefulWidget {
  @override
  State<Iller> createState() => _IllerState();
}

class _IllerState extends State<Iller> {
  List<Il> _tumiller = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _jsonCozumle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("iller"),
      ),
      body: ListView.builder(
        itemCount: _tumiller.length,
        itemBuilder: _buildListItem,
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Il il = _tumiller[index];
    return Card(
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(il.isim),
            Text(il.plakaKodu),
          ],
        ),
        leading: Icon(Icons.location_city),
        children: il.ilceler.map((ilce) {
          return ListTile(
            title: Text(ilce.name),
          );
        }).toList(),
      ),
    );
  }

  void _jsonCozumle() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/iller_ilceler.json');
      Map<String, dynamic> illerMap = json.decode(jsonString);

      for (String plakaKodu in illerMap.keys) {
        Map<String, dynamic> ilMap = illerMap[plakaKodu];
        String ilismi = ilMap["name"];
        Map<String, dynamic> ilcelerMap = ilMap["districts"];

        List<Ilce> tumIlceler = [];

        for (String ilceKodu in ilcelerMap.keys) {
          Map<String, dynamic> ilceMap = ilcelerMap[ilceKodu];
          Ilce ilce = Ilce(ilceMap["name"]);
          tumIlceler.add(ilce);
        }
        Il il = Il(ilismi, plakaKodu, tumIlceler);
        _tumiller.add(il);
      }
      setState(() {});
    } catch (e) {
      print("Bir hata oluştu: \${e.toString()}");
    }
  }
}
