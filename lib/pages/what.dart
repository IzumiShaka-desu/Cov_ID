import 'package:flutter/material.dart';

class What extends StatefulWidget {
  @override
  _WhatState createState() => _WhatState();
}

class _WhatState extends State<What> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.grey[100],
          child: SingleChildScrollView(
                      child: Column(children: [
              Container(
                  height: 200,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/doctor_4.png"),
                          fit: BoxFit.contain,
                          alignment: Alignment.centerRight),
                      color: Colors.deepPurple,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey, spreadRadius: 5, blurRadius: 10)
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 25),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Text(
                                "Apa yang bisa kita lakukan ? ",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            )),
                            SizedBox(width: 25)
                          ],
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: Column(children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            color: Colors.white),
                        child: ListTile(title: Text("Cara Mengenali ")),
                      ),
                      Container(
                        height: 200,
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: <Widget>[
                              _cardHow("fever.png", "Demam 38 \u{B0} C"),
                              _cardHow("cough.png", "Batuk Kering"),
                              _cardHow("headache.png", "Sakit Kepala"),
                              _cardHow("shortbreath.png", "Sulit Bernafas"),
                              _cardHow("sorethroat.png", "Sakit Tenggorokan"),
                            ],
                          ))
                    ]),
                  )
                ]),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                    child: Column(children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            color: Colors.white),
                        child: ListTile(title: Text("Cara Menghindari ")),
                      ),
                      Container(
                          height: 200,
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: <Widget>[
                              _cardHow("washHand.png", "Mencuci Tangan"),
                              _cardHow("wearMask.png", "Gunakan Masker"),
                              _cardHow("selfcarantine.png", "Self Carantine"),
                              _cardHow("hansanitizer.png", "Sterilkan Tangan"),
                              _cardHow("handshake.png", "Hindari Kontak Fisik"),
                            ],
                          ))
                    ]),
                  )
                ]),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

_cardHow(String s, String t) {
  return Container(
    height: 150,
    width: 150,
    child: Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(t),
          Expanded(
              child: Image(
            image: AssetImage("assets/images/$s"),
          ))
        ],
      ),
    )),
  );
}
