import 'dart:core';
import 'dart:ui';
import 'package:Cov_id/api/api_provider.dart';
import 'package:Cov_id/models/corona_model.dart';
import 'package:Cov_id/util/constant.dart';
import 'package:Cov_id/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  Dashboard();

  @override
  _DashboardState createState() => _DashboardState();
}

String area = ApiProvider().getProvinceNow;
String stat='refresh';

@override
void initState() {}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ApiProvider>(
      create: (context) => ApiProvider(),
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
                onPressed: () async {
                  var dial = await showDialog(
                      context: this.context,
                      child: SimpleDialog(
                        title: Container(
                          padding: EdgeInsets.all(5),
                          child: Text("Tentang pembuat"),
                        ),
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Nama : Sesaka Aji Nursyah Bantani")
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Email : shakaaji29@gmail.com")
                                  ],
                                ),
                                Row(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(25),
                                      child: RaisedButton(
                                          child: Text("Close"),
                                          onPressed: () =>
                                              Navigator.pop(context, true)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                        titlePadding: EdgeInsets.all(5),
                      ));
                })
          ],
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Text(
                "Cov ID",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: Colors.grey[50],
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 20, left: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/doctor_3.png"),
                        fit: BoxFit.contain,
                        alignment: Alignment.topRight),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey, spreadRadius: 5, blurRadius: 10)
                    ],
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(50)),
                    border: Border.all(color: Colors.deepPurple),
                    color: Colors.deepPurple,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          Text(
                            "Apakah anda merasa sakit?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      text:
                                          "Jika anda sedang merasakan  gejala - gejala covid-19 sebaiknya anda menghubungi pihak terkait secepatnya untuk mendapatkan pertolongan."),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(children: [
                          MaterialButton(
                            elevation: 10,
                            focusElevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Colors.red,
                            onPressed: () {
                              call("117");
                            },
                            child: Row(children: [
                              Icon(
                                Icons.call,
                                color: Colors.white,
                              ),
                              Text(
                                "Panggil bantuan",
                                style: TextStyle(color: Colors.white),
                              )
                            ]),
                          )
                        ]),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                  width: double.infinity,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.location_on),
                              SizedBox(width: 10),
                              Consumer<ApiProvider>(
                                builder: (context, api, _) => Expanded(
                                    child: DropdownButton(
                                  isExpanded: true,
                                  value: area = api.getProvinceNow,
                                  underline: SizedBox(),
                                  items: provinces
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                        value: value, child: Text(value));
                                  }).toList(),
                                  onChanged: (String value) {
                                    int index = provinces.indexOf(value);
                                    api.setIndexProv = index;
                                    setState(() {
                                      if (value != "Indonesia") area = value;
                                    });
                                  },
                                )),
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(15),
                    width: double.infinity,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "  kasus terbaru",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Consumer<ApiProvider>(
                                builder: (context, api, _) => GestureDetector(
                                  onTap: () {
                                    api.update();
                                  },
                                  child: Text(
                                    api.getStat,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  top: 10, left: 5, right: 5, bottom: 5),
                              height: 110,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: createCard())
                        ]),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    return await showDialog(
                        context: context,
                        child: AlertDialog(
                          title: Text("Warning"),
                          content: Text("Peta pesebaran belum tersedia"),
                        ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(15),
                    width: double.infinity,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "  Peta Sebaran",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 10, left: 5, right: 5, bottom: 5),
                            width: double.infinity,
                            height: 167,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/map.jpg",
                                    ),
                                    fit: BoxFit.fill),
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10))),
                          )
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

createCard() {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Consumer<ApiProvider>(
              builder: (context, api, _) =>
                  _cardInfo(TypeCase.positif, api, Colors.orange)),
        ),
        Expanded(
          child: Consumer<ApiProvider>(
              builder: (context, api, _) =>
                  _cardInfo(TypeCase.death, api, Colors.redAccent)),
        ),
        Expanded(
          child: Consumer<ApiProvider>(
              builder: (context, api, _) =>
                  _cardInfo(TypeCase.recover, api, Colors.green)),
        )
      ]);
}

_cardInfo(TypeCase type, ApiProvider apiProvider, Color color) {
  return FutureBuilder<CoronaModel>(
      future: apiProvider.getDataAsync(),
      builder: (context, snapshot) {
        Widget widget;
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            widget = circularProgressIndicator;
            break;
          case ConnectionState.waiting:
            widget = circularProgressIndicator;
            break;
          case ConnectionState.active:
            widget = circularProgressIndicator;
            break;
          case ConnectionState.done:
          apiProvider.statset="refresh";
            if (snapshot.hasError) {
              widget = errindicator(apiProvider.update());
            } else if (snapshot.hasData) {
              switch (type) {
                case TypeCase.positif:
                  widget = Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(children: [
                      Text(
                        "Positif",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: color),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            snapshot.data.nonNullPositif(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: color),
                          ),
                        ),
                      )
                    ]),
                  );

                  break;
                case TypeCase.death:
                  widget = Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(children: [
                      Text(
                        "Meninggal",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: color),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            snapshot.data.nonNullDeath(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: color),
                          ),
                        ),
                      )
                    ]),
                  );
                  break;
                case TypeCase.recover:
                  widget = Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(children: [
                      Text(
                        "Sembuh",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: color),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            snapshot.data.nonNullRecovered(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: color),
                          ),
                        ),
                      )
                    ]),
                  );
                  break;
              }
              break;
            } else {
              widget = errindicator(apiProvider.update());
            }
        }
        return widget;
      });
}
